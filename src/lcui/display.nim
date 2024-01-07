##
##  display.h -- Graphic display control
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

import lcui, surface, gui/widget

include incl

##  图形显示模式

type
  LCUI_DisplayMode* = enum
    LCUI_DMODE_WINDOWED = 1,    ## < 窗口化
    LCUI_DMODE_SEAMLESS,      ## < 与系统GUI无缝结合
    LCUI_DMODE_FULLSCREEN     ## < 全屏模式


const
  LCUI_DMODE_DEFAULT* = Lcui_Dmode_Windowed

##  显示驱动的事件类型

type
  LCUI_DisplayEventType* = enum
    LCUI_DEVENT_NONE, LCUI_DEVENT_PAINT, LCUI_DEVENT_RESIZE,
    LCUI_DEVENT_MINMAXINFO, LCUI_DEVENT_READY
  LCUI_MinMaxInfoRec* {.bycopy.} = object
    minWidth*: cint
    minHeight*: cint
    maxWidth*: cint
    maxHeight*: cint

  LCUI_MinMaxInfo* = ptr LCUI_MinMaxInfoRec


##  显示驱动的事件数据结构

type
  INNER_C_STRUCT_display_5* {.bycopy.} = object
    rect*: LCUI_Rect

  INNER_C_STRUCT_display_6* {.bycopy.} = object
    width*: cint
    height*: cint

  INNER_C_UNION_display_4* {.bycopy, union.} = object
    paint*: INNER_C_STRUCT_display_5
    resize*: INNER_C_STRUCT_display_6
    minmaxinfo*: LCUI_MinMaxInfoRec

  LCUI_DisplayEventRec* {.bycopy.} = object
    `type`*: cint
    anoDisplay7*: INNER_C_UNION_display_4
    surface*: LCUI_Surface

  LCUI_DisplayEvent* = ptr LCUI_DisplayEventRec

##  surface 的操作方法集

type
  LCUI_DisplayDriverRec* {.bycopy.} = object
    name*: array[256, char]
    getWidth*: proc (): cint {.cdecl.}
    getHeight*: proc (): cint {.cdecl.}
    create*: proc (): LCUI_Surface {.cdecl.}
    destroy*: proc (a1: LCUI_Surface) {.cdecl.}
    close*: proc (a1: LCUI_Surface) {.cdecl.}
    resize*: proc (a1: LCUI_Surface; a2: cint; a3: cint) {.cdecl.}
    move*: proc (a1: LCUI_Surface; a2: cint; a3: cint) {.cdecl.}
    show*: proc (a1: LCUI_Surface) {.cdecl.}
    hide*: proc (a1: LCUI_Surface) {.cdecl.}
    update*: proc (a1: LCUI_Surface) {.cdecl.}
    present*: proc (a1: LCUI_Surface) {.cdecl.}
    isReady*: proc (a1: LCUI_Surface): Lcui_Bool {.cdecl.}
    beginPaint*: proc (a1: LCUI_Surface; a2: ptr LCUI_Rect): LCUI_PaintContext {.cdecl.}
    endPaint*: proc (a1: LCUI_Surface; a2: LCUI_PaintContext) {.cdecl.}
    setCaptionW*: proc (a1: LCUI_Surface; a2: WideCString) {.cdecl.} 
    setRenderMode*: proc (a1: LCUI_Surface; a2: cint) {.cdecl.}
    getHandle*: proc (a1: LCUI_Surface): pointer {.cdecl.}
    getSurfaceWidth*: proc (a1: LCUI_Surface): cint {.cdecl.}
    getSurfaceHeight*: proc (a1: LCUI_Surface): cint {.cdecl.}
    setOpacity*: proc (a1: LCUI_Surface; a2: cfloat) {.cdecl.}
    bindEvent*: proc (a1: cint; a2: LCUI_EventFunc; a3: pointer;
                    a4: proc (a1: pointer) {.cdecl.}): cint {.cdecl.}

  LCUI_DisplayDriver* = ptr LCUI_DisplayDriverRec

##  设置呈现模式

proc displaySetMode*(mode: cint): cint {.lcui, importc: "LCUIDisplay_SetMode".}
##  获取屏幕显示模式

proc displayGetMode*(): cint {.lcui, importc: "LCUIDisplay_GetMode".}
##  更新各种图形元素

proc displayUpdate*() {.lcui, importc: "LCUIDisplay_Update".}
##  渲染内容

proc displayRender*(): csize_t {.lcui, importc: "LCUIDisplay_Render".}
##  呈现渲染后的内容

proc displayPresent*() {.lcui, importc: "LCUIDisplay_Present".}
proc displayEnablePaintFlashing*(enable: Lcui_Bool) {.lcui,
    importc: "LCUIDisplay_EnablePaintFlashing".}
##  设置显示区域的尺寸，仅在窗口化、全屏模式下有效

proc displaySetSize*(width: cint; height: cint) {.lcui,
    importc: "LCUIDisplay_SetSize".}
##  获取屏幕宽度

proc displayGetWidth*(): cint {.lcui, importc: "LCUIDisplay_GetWidth".}
##  获取屏幕高度

proc displayGetHeight*(): cint {.lcui, importc: "LCUIDisplay_GetHeight".}
##  添加无效区域

proc displayInvalidateArea*(rect: ptr LCUI_Rect) {.lcui,
    importc: "LCUIDisplay_InvalidateArea".}
##  获取当前部件所属的 surface

proc displayGetSurfaceOwner*(w: LCUI_Widget): LCUI_Surface {.lcui,
    importc: "LCUIDisplay_GetSurfaceOwner".}
##  根据 handle 获取 surface

proc displayGetSurfaceByHandle*(handle: pointer): LCUI_Surface {.lcui,
    importc: "LCUIDisplay_GetSurfaceByHandle".}
##  绑定 surface 触发的事件

proc displayBindEvent*(eventId: cint; `func`: LCUI_EventFunc; arg: pointer;
                          data: pointer; destroyData: proc (a1: pointer) {.cdecl.}): cint {.
    lcui, importc: "LCUIDisplay_BindEvent".}
##  初始化图形输出模块

proc initDisplay*(driver: LCUI_DisplayDriver): cint {.lcui,
    importc: "LCUI_InitDisplay".}
##  停用图形输出模块

proc freeDisplay*(): cint {.lcui, importc: "LCUI_FreeDisplay".}
##  LCUI_END_HEADER
