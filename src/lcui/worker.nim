##
##  worker.h -- worker threading and task
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
##  #ifndef LCUI_WORKER_H
##  #define LCUI_WORKER_H
##

import lcui

include incl

type
  LCUI_Worker* = pointer
  LCUI_TaskFunc* = proc (a1: pointer; a2: pointer) {.cdecl.}
  LCUI_TaskRec* {.bycopy.} = object
    `func`*: LCUI_TaskFunc
    ## < 任务处理函数
    arg*: array[2, pointer]
    ## < 两个参数
    ## void(*destroy_arg[2])(void*);	/**< 参数的销毁函数 */

  LCUI_Task* = ptr LCUI_TaskRec

proc taskDestroy*(task: LCUI_Task) {.lcui, importc: "LCUITask_Destroy".}
proc taskRun*(task: LCUI_Task): cint {.lcui, importc: "LCUITask_Run".}
proc workerNew*(): LCUI_Worker {.lcui, importc: "LCUIWorker_New".}
proc workerPostTask*(worker: LCUI_Worker; task: LCUI_Task) {.lcui,
    importc: "LCUIWorker_PostTask".}
proc workerGetTask*(worker: LCUI_Worker): LCUI_Task {.lcui,
    importc: "LCUIWorker_GetTask".}
proc workerRunTask*(worker: LCUI_Worker): Lcui_Bool {.lcui,
    importc: "LCUIWorker_RunTask".}
proc workerRunAsync*(worker: LCUI_Worker): cint {.lcui,
    importc: "LCUIWorker_RunAsync".}
proc workerDestroy*(worker: LCUI_Worker) {.lcui, importc: "LCUIWorker_Destroy".}
##  #endif

