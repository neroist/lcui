##
##  timer.h -- timer support.
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
##  #ifndef LCUI_TIMER_H
##  #define LCUI_TIMER_H
##  LCUI_BEGIN_HEADER

include incl

type
  TimerCallback* = proc (a1: pointer) {.cdecl.}

##
##  设置定时器
##  定时器的作用是让一个任务在经过指定时间后才执行
##  @param n_ms
## 	等待的时间，单位为毫秒
##  @param callback_
## 	用于响应定时器的回调函数
##  @param reuse
## 	
## 指示该定时器是否重复使用，如果要用于循环定时处理某些任
## 	务，可将它置为 TRUE，否则置于 FALSE。
##  @return
## 	该定时器的标识符
##

proc timerSet*(nMs: clong; callback: TimerCallback; arg: pointer; reuse: uint8): cint {.
    lcui, importc: "LCUITimer_Set".}
##  repeatedly calls a function, with a fixed time delay between each call.

proc setTimeout*(nMs: clong; callback: TimerCallback; arg: pointer): cint {.lcui,
    importc: "LCUI_SetTimeout".}
##  set a timer which execute a function once after the timer expires.

proc setInterval*(nMs: clong; callback: TimerCallback; arg: pointer): cint {.lcui,
    importc: "LCUI_SetInterval".}
##
##  释放定时器
##
## 当不需要定时器时，可以使用该函数释放定时器占用的资源，并移除程序任务队列
##  中还未处理的定时器任务
##  @param timer_id
## 	需要释放的定时器的标识符
##  @return
## 	正常返回0，指定ID的定时器不存在则返回-1.
##

proc timerFree*(timerId: cint): cint {.lcui, importc: "LCUITimer_Free".}
##
##  暂停定时器的倒计时
##  一般用于往复定时的定时器
##  @param timer_id
## 	目标定时器的标识符
##  @return
## 	正常返回0，指定ID的定时器不存在则返回-1.
##

proc timerPause*(timerId: cint): cint {.lcui, importc: "LCUITimer_Pause".}
##
##  继续定时器的倒计时
##  @param timer_id
## 	目标定时器的标识符
##  @return
## 	正常返回0，指定ID的定时器不存在则返回-1.
##

proc timerContinue*(timerId: cint): cint {.lcui, importc: "LCUITimer_Continue".}
##
##  重设定时器的等待时间
##  @param timer_id
## 	需要释放的定时器的标识符
##  @param n_ms
## 	等待的时间，单位为毫秒
##  @return
## 	正常返回0，指定ID的定时器不存在则返回-1.
##

proc timerReset*(timerId: cint; nMs: clong): cint {.lcui,
    importc: "LCUITimer_Reset".}
##  Process all active timers

proc processTimers*(): csize_t {.lcui, importc: "LCUI_ProcessTimers".}
##  Init the timer module

proc initTimer*() {.lcui, importc: "LCUI_InitTimer".}
##  Free the timer module

proc freeTimer*() {.lcui, importc: "LCUI_FreeTimer".}
##  LCUI_END_HEADER
##  #endif

