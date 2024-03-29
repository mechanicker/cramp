// -*-c++-*-
// Time-stamp: <2004-03-11 11:30:47 dky>
//-----------------------------------------------------------------------------
// File : cramp.h
// Desc : cramp header file
// Usage: Include this in all CRAMP source files
//-----------------------------------------------------------------------------
// mm-dd-yyyy  History                                                      tri
// 09-22-2003  Cre                                                          dky
//-----------------------------------------------------------------------------
#pragma once
#pragma warning (disable:4786)

// Needed for W2K
#define _WIN32_WINNT 0x0500

// Windows definitions
#include <Windows.h>
#include <stdio.h>
#include <process.h>
#include <Pdh.h>
#include <pcre.h>

#include <list>
#include <queue>
#include <string>
#include <hash_map>

#define HAVE_FILTER
//-----------------------------------------------------------------------------
// Global for CRAMP Profiler
//-----------------------------------------------------------------------------
typedef struct{
    unsigned long _calls;
    BOOLEAN _pending;
    BOOLEAN _filtered;
    __int64 _maxticks;
    __int64 _totalticks;
}FuncInfo;

typedef struct{
    char logpath[256];
    BOOLEAN g_exclusion;

    FILE *g_fLogFile;
    FILE *g_fFuncInfo;

    long IsInitialised;

    unsigned int g_pid;
    long g_l_profile;
    long g_l_stoplogging;
    long g_l_maxcalllimit;
    long g_l_logsizelimit;
    long g_l_calldepthlimit;

    pcre *g_regcomp;
    pcre_extra *g_regstudy;

    std::string g_FilterString;
    std::queue<std::string> g_LogQueue;
    std::hash_map<unsigned int,FuncInfo> g_hFuncCalls;
    std::hash_map<unsigned int,BOOLEAN> h_FilteredModAddr;

    HANDLE g_h_mailslot;
    HANDLE g_h_mailslotTH;
    HANDLE g_h_logsizemonTH;
    CRITICAL_SECTION g_cs_fun;
    CRITICAL_SECTION g_cs_log;
    CRITICAL_SECTION g_cs_prof;

}Global_CRAMP_Profiler;

#ifndef __DLLMAIN_SRC
extern Global_CRAMP_Profiler g_CRAMP_Profiler;
#endif
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Global for CRAMP Engine
//-----------------------------------------------------------------------------
class TestCaseInfo;
typedef struct{
    HANDLE g_hJOB;
    HANDLE g_hMUT;
    HANDLE g_hIOCP;
    HANDLE g_hJOBTimer;
    PDH_HQUERY g_hQuery;

    char g_JOBNAME[256];
    FILE *g_fLogFile;
    long g_l_stopengine;
    DWORD g_scenariostatus;

    TestCaseInfo *g_pScenario;

    CRITICAL_SECTION g_cs_gc;
    CRITICAL_SECTION g_cs_log;
}Global_CRAMP_Engine;

#ifndef __MAIN_SRC
extern Global_CRAMP_Engine g_CRAMP_Engine;
#endif
//-----------------------------------------------------------------------------

//------------------------ MACROS AND DEFINED ---------------------------------
#define JOB_NAME "CRAMPENGINE_JOB"
#define MUTEX_NAME "CRAMPENGINE_MUTEX"
#define CRAMP_PROFILE_LIMIT 1000

#ifndef BUFSIZE
#define BUFSIZE 1024
#endif

#define BARF() do{                                  \
    fprintf(g_LogFile,"%d:%s\n",__LINE__,__FILE__); \
    fflush(g_LogFile);                              \
  }while(0)

// Courtesy: Jeffrey Richter
#ifdef _X86_
#define DebugBreak() _asm { int 3 }
#endif

typedef unsigned (__stdcall *PTHREAD_START) (void *);
#define chBEGINTHREADEX(psa, cbStack, pfnStartAddr,         \
                        pvParam, fdwCreate, pdwThreadId)    \
  ((HANDLE)_beginthreadex(                                  \
    (void *)        (psa),                                  \
    (unsigned)      (cbStack),                              \
    (PTHREAD_START) (pfnStartAddr),                         \
    (void *)        (pvParam),                              \
    (unsigned)      (fdwCreate),                            \
    (unsigned *)    (pdwThreadId)))

#ifndef DEBUGCHK
#ifdef CRAMP_DEBUG
#define DEBUGCHK(expr) if(!expr) DebugBreak()
#else
#define DEBUGCHK(expr) if(!expr) ExitProcess(-1)
#endif
#endif

//------------------------ MACROS AND DEFINED ---------------------------------

//-----------------------------------------------------------------------------
// Class: CRAMPException
// Desc : A generic CRAMP exception class. Derive all cramp exceptions from
//        CRAMPException.
//-----------------------------------------------------------------------------
class CRAMPException{
public:
    CRAMPException(){};
    ~CRAMPException(){};

    SIZE_T _error;
    std::string _message;
};

//-----------------------------------------------------------------------------
//                         CRITICAL_SECTION - Scopped
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// For profiler
//-----------------------------------------------------------------------------
class CRAMP_CS{
public:
    CRAMP_CS(CRITICAL_SECTION *crit){
        _ref=FALSE;
        _pcs=crit;
    };
    virtual ~CRAMP_CS(){
        if(_ref&&_pcs)
            LeaveCriticalSection(_pcs);
    };
    void enter(void){
        if(_ref||!_pcs)
            return;
        EnterCriticalSection(_pcs);
        _ref=!_ref;
        return;
    };
    void leave(void){
        if(!_ref||!_pcs)
            return;
        LeaveCriticalSection(_pcs);
        _ref=!_ref;
        return;
    };
private:
    CRAMP_CS(){};
    bool _ref;
    CRITICAL_SECTION *_pcs;
};
