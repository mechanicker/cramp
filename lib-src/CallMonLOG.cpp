// -*-c++-*-
// Time-stamp: <2004-03-11 11:31:13 dky>
//-----------------------------------------------------------------------------
// File: CallMonLOG.h
// Desc: Derived class to over ride the log file generation
//-----------------------------------------------------------------------------
// mm-dd-yyyy  History                                                      tri
// 09-30-2003  Cre                                                          dky
// 09-30-2003  Mod  Made time in micro seconds                              dky
// 12-12-2003  Mod  Replaced exception with RAW ticks                       dky
//-----------------------------------------------------------------------------
#define __CALLMONLOG_SRC

#include "CallMonLOG.h"

#include <queue>
#include <string>
#include <hash_map>

extern Global_CRAMP_Profiler g_CRAMP_Profiler;

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
//  If the "rawticks" is 0 => Exception. Any other -ve value => BIG PROBLEM
//-----------------------------------------------------------------------------
void
CallMonLOG::logExit(CallInfo &ci,bool normalRet){
    TICKS rawticks=0;
    TICKS ticksPerSecond=0;
    TICKS elapsedticks=(ci.endTime-ci.startTime-ci.ProfilingTicks);

    if(normalRet)
        rawticks=elapsedticks-ci.RawChildTicks;

    queryTickFreq(&ticksPerSecond);

    std::hash_map<ADDR,FuncInfo>::iterator iter;
    CRAMP_CS cs(&g_CRAMP_Profiler.g_cs_prof);
    cs.enter();

    iter=g_CRAMP_Profiler.g_hFuncCalls.find(ci.funcAddr);
    if(iter==g_CRAMP_Profiler.g_hFuncCalls.end())
        return;

    (*iter).second._totalticks+=elapsedticks;
    if((*iter).second._maxticks<elapsedticks)
        (*iter).second._maxticks=elapsedticks;

    // For stats only
    if(!g_CRAMP_Profiler.g_fLogFile)
        return;
    cs.leave();

    CRAMP_CS csl(&g_CRAMP_Profiler.g_cs_log);
    csl.enter();
    fprintf(g_CRAMP_Profiler.g_fLogFile,"%d|%08X|%d|%I64d|%I64d|%I64d\n",
            _tid,
            ci.funcAddr,
            callInfoStack.size(),
            rawticks,
            elapsedticks/(ticksPerSecond/1000000),
            elapsedticks);
    csl.leave();

    return;
}
