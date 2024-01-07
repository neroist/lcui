##
##  thread.h -- basic thread management
##
##  Copyright (c) 2018, Liu chao <lc-soft@live.cn> All rights reserved.
##
##  Redistribution and use in source and binary forms, with or without
##  modification, are permitted provided that the following conditions are met:
##
##    * Redistributions of source code must retain the above copyright notice,
##      this list of conditions and the following disclaimer.
##    * Redistributions in binary form must reproduce the above copyright
##      notice, this list of conditions and the following disclaimer in the
##      documentation and/or other materials provided with the distribution.
##    * Neither the name of LCUI nor the names of its contributors may be used
##      to endorse or promote products derived from this software without
##      specific prior written permission.
##
##  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
##  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
##  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
##  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
##  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
##  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
##  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
##  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
##  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
##  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
##  POSSIBILITY OF SUCH DAMAGE.
##
##  #ifndef LCUI_THREAD_H
##  #define LCUI_THREAD_H
##
##  #ifdef _WIN32
##  #include <windows.h>
##  typedef HANDLE LCUI_Mutex;
##  typedef HANDLE LCUI_Cond;
##  typedef unsigned int LCUI_Thread;
##  #else
##  #include <pthread.h>
##  typedef pthread_t LCUI_Thread;
##  typedef pthread_mutex_t LCUI_Mutex;
##  typedef pthread_cond_t LCUI_Cond;
##  #endif
##  LCUI_BEGIN_HEADER

include incl

type
  LCUI_Mutex* = pointer
  LCUI_Cond* = pointer # ?
  LCUI_Thread* = cint

## ----------------------------- Mutex <START> -------------------------------
##  init the mutex

proc mutexInit*(mutex: ptr LCUI_Mutex): cint {.lcui, importc: "LCUIMutex_Init".}
##  Free the mutex

proc mutexDestroy*(mutex: ptr LCUI_Mutex) {.lcui, importc: "LCUIMutex_Destroy".}
##  Try lock the mutex

proc mutexTryLock*(mutex: ptr LCUI_Mutex): cint {.lcui,
    importc: "LCUIMutex_TryLock".}
##  Lock the mutex

proc mutexLock*(mutex: ptr LCUI_Mutex): cint {.lcui, importc: "LCUIMutex_Lock".}
##  Unlock the mutex

proc mutexUnlock*(mutex: ptr LCUI_Mutex): cint {.lcui,
    importc: "LCUIMutex_Unlock".}
## ------------------------------- Mutex <END> -------------------------------
## ------------------------------ Cond <START> -------------------------------
##  初始化一个条件变量

proc condInit*(cond: ptr LCUI_Cond): cint {.lcui, importc: "LCUICond_Init".}
##  销毁一个条件变量

proc condDestroy*(cond: ptr LCUI_Cond): cint {.lcui, importc: "LCUICond_Destroy".}
##  阻塞当前线程，等待条件成立

proc condWait*(cond: ptr LCUI_Cond; mutex: ptr LCUI_Mutex): cint {.lcui,
    importc: "LCUICond_Wait".}
##  计时阻塞当前线程，等待条件成立

proc condTimedWait*(cond: ptr LCUI_Cond; mutex: ptr LCUI_Mutex; ms: cuint): cint {.
    lcui, importc: "LCUICond_TimedWait".}
##  唤醒一个阻塞等待条件成立的线程

proc condSignal*(cond: ptr LCUI_Cond): cint {.lcui, importc: "LCUICond_Signal".}
##  唤醒所有阻塞等待条件成立的线程

proc condBroadcast*(cond: ptr LCUI_Cond): cint {.lcui,
    importc: "LCUICond_Broadcast".}
## ------------------------------- Cond <END> --------------------------------
## ----------------------------- Thread <START> ------------------------------

proc threadSelfID*(): LCUI_Thread {.lcui, importc: "LCUIThread_SelfID".}
##  创建并运行一个线程

proc threadCreate*(tidp: ptr LCUI_Thread; startRtn: proc (a1: pointer) {.cdecl.};
                      arg: pointer): cint {.lcui, importc: "LCUIThread_Create".}
##  等待一个线程的结束，并释放该线程的资源

proc threadJoin*(thread: LCUI_Thread; retval: ptr pointer): cint {.lcui,
    importc: "LCUIThread_Join".}
##  撤销一个线程

proc threadCancel*(thread: LCUI_Thread) {.lcui, importc: "LCUIThread_Cancel".}
##  记录指针作为返回值，并退出线程

proc threadExit*(retval: pointer) {.lcui, importc: "LCUIThread_Exit".}
## ------------------------------ Thread <END> -------------------------------
##  LCUI_END_HEADER
##  #endif
