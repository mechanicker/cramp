// -*-c++-*-
// Time-stamp: <2003-10-31 21:28:18 dhruva>
//-----------------------------------------------------------------------------
// File: CallMonLOG.h
// Desc: Derived class to over ride the log file generation
//-----------------------------------------------------------------------------
// mm-dd-yyyy  History                                                      tri
// 09-30-2003  Mod                                                          dky
//-----------------------------------------------------------------------------
#define __CALLMONLOG_SRC

#include "CallMonLOG.h"
#include "ProfileLimit.h"

#include <queue>
#include <string>
#include <hash_map>

extern FILE *g_fLogFile;
extern CRITICAL_SECTION g_cs_log;
extern CRITICAL_SECTION g_cs_prof;
extern std::queue<std::string> g_LogQueue;
extern std::hash_map<unsigned int,FuncInfo> g_hFuncCalls;
extern BOOL WriteFuncInfo(unsigned int,unsigned long);

//-----------------------------------------------------------------------------
// CallMonLOG
//-----------------------------------------------------------------------------
CallMonLOG::CallMonLOG(){
  _tid=GetCurrentThreadId();
}

//-----------------------------------------------------------------------------
// ~CallMonLOG
//-----------------------------------------------------------------------------
CallMonLOG::~CallMonLOG(){
}

//-----------------------------------------------------------------------------
// logEntry
//  Use this to generate function call graph
//-----------------------------------------------------------------------------
void
CallMonLOG::logEntry(CallInfo &ci){
  return;
}

//-----------------------------------------------------------------------------
// logExit
//  Use this to output the profile information
//-----------------------------------------------------------------------------
void
CallMonLOG::logExit(CallInfo &ci,bool normalRet){
  TICKS ticksPerSecond;
  TICKS elapsedticks=(ci.endTime-ci.startTime-ci.ProfileTime);

  queryTickFreq(&ticksPerSecond);

  std::hash_map<ADDR,FuncInfo>::iterator iter;
  EnterCriticalSection(&g_cs_prof);
  iter=g_hFuncCalls.find(ci.funcAddr);
  if(iter==g_hFuncCalls.end()){
    FuncInfo fi={1,TRUE,elapsedticks,elapsedticks};
    fi._pending=WriteFuncInfo(ci.funcAddr,1);
    g_hFuncCalls[ci.funcAddr]=fi;
  }else{
    (*iter).second._calls++;
    (*iter).second._totalticks+=elapsedticks;
    if((*iter).second._maxticks<elapsedticks)
      (*iter).second._maxticks=elapsedticks;
  }
  LeaveCriticalSection(&g_cs_prof);

  EnterCriticalSection(&g_cs_log);
  fprintf(g_fLogFile,"%d|%08X|%d|%d|%I64d|%I64d\n",
          _tid,
          ci.funcAddr,
          callInfoStack.size(),
          !normalRet,
          elapsedticks/(ticksPerSecond/1000),
          elapsedticks);
  LeaveCriticalSection(&g_cs_log);

  return;
}
