##
##  cursor.h -- Mouse cursor operation set.
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

import lcui

include incl

##  初始化游标数据

proc initCursor*() {.lcui, importc: "LCUI_InitCursor".}
proc freeCursor*() {.lcui, importc: "LCUI_FreeCursor".}
##  获取鼠标游标的区域范围

proc cursorGetRect*(rect: ptr LCUI_Rect) {.lcui, importc: "LCUICursor_GetRect".}
##  刷新鼠标游标在屏幕上显示的图形

proc cursorRefresh*() {.lcui, importc: "LCUICursor_Refresh".}
##  检测鼠标游标是否可见

proc cursorIsVisible*(): Lcui_Bool {.lcui, importc: "LCUICursor_IsVisible".}
##  显示鼠标游标

proc cursorShow*() {.lcui, importc: "LCUICursor_Show".}
##  隐藏鼠标游标

proc cursorHide*() {.lcui, importc: "LCUICursor_Hide".}
##  更新鼠标指针的位置

proc cursorUpdate*() {.lcui, importc: "LCUICursor_Update".}
##  设定游标的位置

proc cursorSetPos*(pos: LCUI_Pos) {.lcui, importc: "LCUICursor_SetPos".}
##  设置游标的图形

proc cursorSetGraph*(graph: ptr LCUI_Graph): cint {.lcui,
    importc: "LCUICursor_SetGraph".}
##  获取鼠标指针当前的坐标

proc cursorGetPos*(pos: ptr LCUI_Pos) {.lcui, importc: "LCUICursor_GetPos".}
proc cursorPaint*(paint: LCUI_PaintContext): cint {.lcui,
    importc: "LCUICursor_Paint".}
##  LCUI_END_HEADER
