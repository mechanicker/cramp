// -*-c++-*-
// Time-stamp: <2004-03-05 14:39:59 dky>
//-----------------------------------------------------------------------------
// File  : engine.cpp
// Desc  : Create a job, process inside the job which may create further
//         processes. Add a callback on the job to notify when a process
//         is added to the job. A timer to monitor the processes in the job.
// TODO  :
//-----------------------------------------------------------------------------
// mm-dd-yyyy  History                                                      tri
// 12-09-2003  Cre                                                          dky
//-----------------------------------------------------------------------------
#define __PERFCOUNTERS_SRC

#include "PerfCounters.h"
#include "TestCaseInfo.h"

#include <Pdh.h>
#include <PDHMsg.h>
#include <Psapi.h>

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>

#include <string>
#include <hash_map>

typedef struct{
    std::string _name;
    PDH_HCOUNTER *_pCounters;
    TCIPID _tcipid;
}CounterInfo;

//--------------------------- FUNCTION PROTOTYPES -----------------------------
BOOL GetNameStrings(void);
void WriteCounterData(void);
void CleanPIDCounterHash(void);
BOOL UpdateCounterList(int,char *);
//--------------------------- FUNCTION PROTOTYPES -----------------------------

static BOOL s_NameStr=FALSE;
std::hash_map<DWORD,CounterInfo> s_h_PIDCounters;

char C_VM_NAME[256];
char C_WS_NAME[256];
char C_PID_NAME[256];
char C_PRIV_NAME[256];
char C_PROC_NAME[256];

//-----------------------------------------------------------------------------
// hashstring
//-----------------------------------------------------------------------------
SIZE_T
hashstring(const char *s){
    if(!s)
        return(0);

    SIZE_T h=0;
    for(int i=0;s[i]!='\0';i+=1)
        h=(h<<5)-h+s[i];

    return(h);
}

//-----------------------------------------------------------------------------
// GetNameStrings
//-----------------------------------------------------------------------------
BOOL
GetNameStrings(void){
    HKEY hKeyPerflib;      // handle to registry key
    HKEY hKeyPerflib009;   // handle to registry key
    DWORD dwMaxValueLen;   // maximum size of key values
    DWORD dwBuffer;        // bytes to allocate for buffers
    DWORD dwBufferSize;    // size of dwBuffer
    LPSTR lpCurrentString; // pointer for enumerating data strings
    DWORD dwCounter;       // current counter index
    LPSTR lpNameStrings;

    // Get the number of Counter items.
    if(RegOpenKeyEx(HKEY_LOCAL_MACHINE,
                    "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Perflib",
                    0,
                    KEY_READ,
                    &hKeyPerflib)!=ERROR_SUCCESS)
        return(FALSE);

    dwBufferSize=sizeof(dwBuffer);
    if(RegQueryValueEx(hKeyPerflib,
                       "Last Counter",
                       NULL,
                       NULL,
                       (LPBYTE)&dwBuffer,
                       &dwBufferSize )!=ERROR_SUCCESS)
        return FALSE;
    RegCloseKey(hKeyPerflib);

    // Open the key containing the counter and object names.
    if(RegOpenKeyEx(HKEY_LOCAL_MACHINE,
                    K_LANG,
                    0,
                    KEY_READ,
                    &hKeyPerflib009)!=ERROR_SUCCESS)
        return(FALSE);

    // Get the size of the largest value in the key (Counter or Help).
    if(RegQueryInfoKey(hKeyPerflib009,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       &dwMaxValueLen,
                       NULL,
                       NULL)!=ERROR_SUCCESS)
        return(FALSE);

    // Allocate memory for the counter and object names.
    dwBuffer=dwMaxValueLen+1;

    lpNameStrings=(char *)malloc(dwBuffer*sizeof(CHAR));
    if(NULL==lpNameStrings)
        return(FALSE);

    BOOL ret=FALSE;
    do{
        // Read the Counter value.
        if(RegQueryValueEx(hKeyPerflib009,
                           "Counter",
                           NULL,
                           NULL,
                           (unsigned char *)lpNameStrings,
                           &dwBuffer)!=ERROR_SUCCESS)
            break;

        // Load names into an array, by index.
        DWORD dwSize;
        for(lpCurrentString=lpNameStrings;
            *lpCurrentString;
            lpCurrentString+=(lstrlen(lpCurrentString)+1)){
            dwCounter=atol(lpCurrentString);
            lpCurrentString+=(lstrlen(lpCurrentString)+1);
            dwSize=256;
            if(!strcmp("Process",lpCurrentString)){
                PdhLookupPerfNameByIndex(".",dwCounter,C_PROC_NAME,&dwSize);
            }else if(!strcmp("Virtual Bytes",lpCurrentString)){
                PdhLookupPerfNameByIndex(".",dwCounter,C_VM_NAME,&dwSize);
            }else if(!strcmp("Private Bytes",lpCurrentString)){
                PdhLookupPerfNameByIndex(".",dwCounter,C_PRIV_NAME,&dwSize);
            }else if(!strcmp("Working Set",lpCurrentString)){
                PdhLookupPerfNameByIndex(".",dwCounter,C_WS_NAME,&dwSize);
            }else if(!strcmp("ID Process",lpCurrentString)){
                PdhLookupPerfNameByIndex(".",dwCounter,C_PID_NAME,&dwSize);
            }
        }
        ret=TRUE;
    }while(0);

    free(lpNameStrings);
    lpNameStrings=0;

    return(ret);
}

//-----------------------------------------------------------------------------
// UpdatePIDCounterHash
//-----------------------------------------------------------------------------
int
UpdatePIDCounterHash(std::list<TCIPID> &iListOfTCIPID){
    if(!iListOfTCIPID.size())
        return(0);

    // Do not check the first time
    if(s_NameStr&&!g_CRAMP_Engine.g_hQuery)
        return(-1);

    DWORD dwSize=0,dwBuffSize=0;
    LPTSTR szObjListBuffer=NULL;

    // Get the name strings through the registry.
    if(!s_NameStr){
        if(!GetNameStrings())
            return(-1);
        s_NameStr=TRUE;
        if(ERROR_SUCCESS!=PdhOpenQuery(NULL,0,&g_CRAMP_Engine.g_hQuery))
            return(-1);
    }else{
        PdhEnumObjects(NULL,
                       ".",
                       NULL,
                       &dwSize,
                       PERF_DETAIL_WIZARD,
                       TRUE);
        szObjListBuffer=(LPTSTR)malloc((dwSize * sizeof(TCHAR)));
        PdhEnumObjects(NULL,
                       ".",
                       szObjListBuffer,
                       &dwSize,
                       PERF_DETAIL_WIZARD,
                       TRUE);
    }

    dwSize=0;
    PdhEnumObjectItems(NULL,
                       ".",
                       C_PROC_NAME,
                       NULL,
                       &dwSize,
                       NULL,
                       &dwBuffSize,
                       PERF_DETAIL_WIZARD,
                       0);

    LPTSTR szCounterListBuffer=NULL;
    LPTSTR szInstanceListBuffer=NULL;
    szCounterListBuffer=(LPTSTR)malloc((dwSize * sizeof(TCHAR)));
    szInstanceListBuffer=(LPTSTR)malloc((dwBuffSize * sizeof(TCHAR)));

    do{
        if(ERROR_SUCCESS!=PdhEnumObjectItems(NULL,
                                             ".",
                                             C_PROC_NAME,
                                             szCounterListBuffer,
                                             &dwSize,
                                             szInstanceListBuffer,
                                             &dwBuffSize,
                                             PERF_DETAIL_WIZARD,
                                             0))
            break;

        char qstr[1024];
        PDH_HQUERY hQuery=0;
        PDH_HCOUNTER c_pid=0;
        PDH_RAW_COUNTER rval={0};
        LPTSTR szThisInstance=NULL;
        std::hash_map<SIZE_T,int> h_inst;
        std::list<TCIPID>::iterator liter;
        std::hash_map<SIZE_T,int>::iterator iiter;
        std::hash_map<DWORD,CounterInfo>::iterator hiter;

        if(ERROR_SUCCESS!=PdhOpenQuery(NULL,0,&hQuery))
            break;

        for(szThisInstance=szInstanceListBuffer;
            *szThisInstance;
            szThisInstance+=lstrlen(szThisInstance)+1){
            DWORD count=0;
            SIZE_T hash=0;
            char inst[256];

            // Handle mixed case exec names as 1
            strcpy(qstr,szThisInstance);
            hash=hashstring(_strlwr(qstr));
            iiter=h_inst.find(hash);
            if(iiter!=h_inst.end()){
                (*iiter).second++;
                count=(*iiter).second;
            }else{
                h_inst[hash]=0;
            }

            if(count)
                sprintf(inst,"%s#%d",szThisInstance,count);
            else
                sprintf(inst,"%s",szThisInstance);

            // Form the PID Query string
            sprintf(qstr,"\\\\.\\%s(%s)\\%s",C_PROC_NAME,inst,C_PID_NAME);

            // Get the PID of the instance
            DEBUGCHK((ERROR_SUCCESS==PdhAddCounter(hQuery,
                                                   qstr,
                                                   0,
                                                   &c_pid)));
            PdhCollectQueryData(hQuery);

            DWORD ipid=0;
            DEBUGCHK((ERROR_SUCCESS==PdhGetRawCounterValue(c_pid,0,&rval)));
            ipid=rval.FirstValue;
            PdhRemoveCounter(c_pid);

            // Scan the list of PIDs
            liter=iListOfTCIPID.begin();
            for(;liter!=iListOfTCIPID.end();liter++){
                DWORD pid=(*liter)._pid;
                if(pid!=ipid)
                    continue;

                hiter=s_h_PIDCounters.find(pid);
                if(hiter!=s_h_PIDCounters.end())
                    continue;

                PDH_HCOUNTER *apdhc=new PDH_HCOUNTER[MAX_COUNTERS];

                sprintf(qstr,"\\\\.\\%s(%s)\\%s",C_PROC_NAME,inst,C_VM_NAME);
                PdhAddCounter(g_CRAMP_Engine.g_hQuery,qstr,0,&apdhc[0]);

                sprintf(qstr,"\\\\.\\%s(%s)\\%s",C_PROC_NAME,inst,C_PRIV_NAME);
                PdhAddCounter(g_CRAMP_Engine.g_hQuery,qstr,0,&apdhc[1]);

                sprintf(qstr,"\\\\.\\%s(%s)\\%s",C_PROC_NAME,inst,C_WS_NAME);
                PdhAddCounter(g_CRAMP_Engine.g_hQuery,qstr,0,&apdhc[2]);

                CounterInfo ci;
                ci._name=inst;
                ci._pCounters=apdhc;
                ci._tcipid=(*liter);
                s_h_PIDCounters[pid]=ci;
            }
        }
        PdhCloseQuery(hQuery);
    }while(0);

    if(szObjListBuffer)
        free(szObjListBuffer);
    if(szCounterListBuffer)
        free(szCounterListBuffer);
    if(szInstanceListBuffer)
        free(szInstanceListBuffer);

    return(0);
}

//-----------------------------------------------------------------------------
// RemovePIDCounterHash
//-----------------------------------------------------------------------------
void
RemovePIDCounterHash(DWORD iPID){
    if(!g_CRAMP_Engine.g_hQuery)
        return;

    std::hash_map<DWORD,CounterInfo>::iterator iter;
    iter=s_h_PIDCounters.find(iPID);
    if(iter==s_h_PIDCounters.end())
        return;
    PDH_HCOUNTER *pcntr=(*iter).second._pCounters;
    s_h_PIDCounters.erase(iter);
    for(int ii=0;ii<MAX_COUNTERS;ii++)
        PdhRemoveCounter(pcntr[ii]);
    delete [] pcntr;

    return;
}

//-----------------------------------------------------------------------------
// CleanPIDCounterHash
//-----------------------------------------------------------------------------
void
CleanPIDCounterHash(void){
    if(!g_CRAMP_Engine.g_hQuery)
        return;

    std::hash_map<DWORD,CounterInfo>::iterator hiter=s_h_PIDCounters.begin();
    for(;hiter!=s_h_PIDCounters.end();hiter++){
        PDH_HCOUNTER *pcntr=(*hiter).second._pCounters;
        for(int ii=0;ii<MAX_COUNTERS;ii++)
            PdhRemoveCounter(pcntr[ii]);
        delete [] pcntr;
    }
    s_h_PIDCounters.erase(s_h_PIDCounters.begin(),s_h_PIDCounters.end());
    PdhCloseQuery(g_CRAMP_Engine.g_hQuery);
    g_CRAMP_Engine.g_hQuery=0;

    return;
}

//-----------------------------------------------------------------------------
// WriteCounterData
//-----------------------------------------------------------------------------
void
WriteCounterData(void){
    if(!g_CRAMP_Engine.g_hQuery)
        return;
    PdhCollectQueryData(g_CRAMP_Engine.g_hQuery);

    char msg[1024];
    SIZE_T vm=0,pb=0,ws=0;
    PDH_FMT_COUNTERVALUE val;
    std::hash_map<DWORD,CounterInfo>::iterator hiter=s_h_PIDCounters.begin();
    for(;hiter!=s_h_PIDCounters.end();hiter++){
        DWORD pid=(*hiter).first;
        PDH_HCOUNTER *pcntr=(*hiter).second._pCounters;
        if(!pcntr)
            continue;

        HANDLE h_proc=0;
        h_proc=OpenProcess(PROCESS_QUERY_INFORMATION|PROCESS_VM_READ,
                           FALSE,pid);
        if(!h_proc)
            continue;

        PdhGetFormattedCounterValue(pcntr[0],PDH_FMT_LONG,0,&val);
        vm=val.longValue;
        PdhGetFormattedCounterValue(pcntr[1],PDH_FMT_LONG,0,&val);
        pb=val.longValue;
        PdhGetFormattedCounterValue(pcntr[2],PDH_FMT_LONG,0,&val);
        ws=val.longValue;

        MEMORYSTATUS mem={0};
        PROCESS_MEMORY_COUNTERS pmc={0};
        GlobalMemoryStatus(&mem);
        GetProcessMemoryInfo(h_proc,&pmc,sizeof(PROCESS_MEMORY_COUNTERS));
        CloseHandle(h_proc);

        // Do not add PID info here, added in AddLog()
        sprintf(msg,"#%s|%ld|%ld|%ld|%ld|%ld",
                (*hiter).second._name.c_str(),
                vm,
                pb,
                ws,
                pmc.QuotaPagedPoolUsage,
                mem.dwAvailPhys);
        (*hiter).second._tcipid._ptc->AddLog(msg);
        msg[0]='\0';
    }

    return;
}
