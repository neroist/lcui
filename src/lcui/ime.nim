##
##  ime.h -- Input Method Engine
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

import std/widestrs

import lcui

include incl

type
  LCUI_IMEHandlerRec* {.bycopy.} = object
    prockey*: proc (a1: cint; a2: cint): uint8 {.cdecl.}
    totext*: proc (a1: cint) {.cdecl.}
    open*: proc (): uint8 {.cdecl.}
    close*: proc (): uint8 {.cdecl.}
    setcaret*: proc (a1: cint; a2: cint) {.cdecl.}

  LCUI_IMEHandler* = ptr LCUI_IMEHandlerRec

##  注册一个输入法

proc iME_Register*(imeName: cstring; handler: LCUI_IMEHandler): cint {.lcui,
    importc: "LCUIIME_Register".}
##  选定输入法

proc iME_Select*(imeId: cint): uint8 {.lcui, importc: "LCUIIME_Select".}
proc iME_SelectByName*(name: cstring): uint8 {.lcui,
    importc: "LCUIIME_SelectByName".}
##  检测键值是否为字符键值

proc iME_CheckCharKey*(key: cint): uint8 {.lcui, importc: "LCUIIME_CheckCharKey".}
##  切换至下一个输入法

proc iME_Switch*() {.lcui, importc: "LCUIIME_Switch".}
##  检测输入法是否要处理按键事件

proc iME_ProcessKey*(e: LCUI_SysEvent): uint8 {.lcui,
    importc: "LCUIIME_ProcessKey".}
##  提交输入法输入的内容至目标

proc iME_Commit*(str: WideCString; len: csize_t): cint {.lcui,
    importc: "LCUIIME_Commit".}
##  初始化LCUI输入法模块

proc initIME*() {.lcui, importc: "LCUI_InitIME".}
##  停用LCUI输入法模块

proc freeIME*() {.lcui, importc: "LCUI_FreeIME".}
## #ifdef LCUI_BUILD_IN_WIN32
## int LCUI_RegisterWin32IME(void);
## #else
## int LCUI_RegisterLinuxIME(void);
## #endif

proc iME_SetCaret*(x: cint; y: cint) {.lcui, importc: "LCUIIME_SetCaret".}
##  LCUI_END_HEADER
