// -*-c++-*-
// Time-stamp: <2004-03-11 11:08:09 dky>
//-----------------------------------------------------------------------------
// File: CallMon.cpp
// Desc: The CallMonitor class definition
//       Copyright (c) 1998 John Panzer.  Permission is granted to
//       use, copy, modify, distribute, and sell this source code as
//       long as this copyright notice appears in all source files.
//-----------------------------------------------------------------------------
// mm-dd-yyyy  History                                                      tri
// 09-30-2003  Mod                                                          dky
//-----------------------------------------------------------------------------
#pragma once
#pragma warning (disable:4786)

#define PENTIUM // Comment out for non-Pentium targets

#include <string>
#include <vector>

#ifndef __CALLMON_SRC
extern long g_profile;
#endif

#ifdef PENTIUM
// Pentium-specific RDTSC instruction -- from www.sysinternals.com
inline
void RDTSC(DWORD &low,long &high)
{
    DWORD L; long H;
    _asm {
        _asm push eax
            _asm push edx
            _asm _emit 0Fh
            _asm _emit 31h
            _asm mov DWORD PTR [L], eax
            _asm mov DWORD PTR [H], edx
            _asm pop edx
            _asm pop eax
            }
    low = L; high = H;
}
#endif

class CallMonitor
{
public:
    typedef unsigned int ADDR;
    typedef __int64 TICKS;     // Timing information

    CallMonitor();
    // Thread-local singleton accessor
    static CallMonitor &threadObj();
    static CallMonitor *threadPtr();

    static void threadAttach(CallMonitor *newObj);
    static void threadDetach();

    // Called when a client function starts
    void enterProcedure(ADDR parentFramePtr,ADDR funcAddr,
                        ADDR *retAddrPtr,
                        const TICKS &entryTime);

    // Called when a client function exits
    void exitProcedure(ADDR parentFramePtr,ADDR *retAddrPtr,
                       const TICKS &endTime);

    // Wrappers for system-dependent timing functions
    static inline void queryTicks(TICKS *t) {
#ifdef PENTIUM
        RDTSC(((LARGE_INTEGER*)t)->LowPart,((LARGE_INTEGER*)t)->HighPart);
#else
        QueryPerformanceCounter((LARGE_INTEGER*)t);
#endif
    }

#ifdef PENTIUM
    static void queryTickFreq(TICKS *t);
#else
    static inline void queryTickFreq(TICKS *t) {
        QueryPerformanceFrequency((LARGE_INTEGER*)t);
    }
#endif

protected:
    // Record for a single call
    struct CallInfo
    {
        ADDR funcAddr;              // Function address
        ADDR parentFrame;           // Parent stack frame address
        ADDR origRetAddr;           // Function return address
        TICKS entryTime;            // Time function was called
        TICKS startTime;            // Time function started
        TICKS endTime;              // Time function returned
        TICKS RawChildTicks;        // Collective RAW children ticks
        TICKS ProfilingTicks;       // Collective profile time of all children
    };
    typedef std::vector<CallInfo> CallInfoStack;

    // Override to log entry events.
    virtual void logEntry(CallInfo &ci)=0;
    // Override to log exit events.
    virtual void logExit(CallInfo &ci,bool normalRet)=0;

    virtual ~CallMonitor();

    // "Shadow" stack of active functions
    CallInfoStack callInfoStack;
    TICKS threadStartTime;  // Time thread started

private:
    static DWORD tlsSlot;
};
