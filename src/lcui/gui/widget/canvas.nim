##
##  canvas.h -- canvas, used to draw custom graphics
##
##  Copyright (c) 2019, Liu chao <lc-soft@live.cn> All rights reserved.
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

import ../widget, ../../lcui

include ../../incl

type
  LCUI_CanvasRenderingContext* = ptr LCUI_CanvasRenderingContextRec
  LCUI_CanvasContext* = LCUI_CanvasRenderingContext
  LCUI_CanvasRenderingContextRec* {.bycopy.} = object
    available*: Lcui_Bool
    fillColor*: LCUI_Color
    buffer*: LCUI_Graph
    canvas*: LCUI_Widget
    node*: LinkedListNode
    scale*: cfloat
    width*: cint
    height*: cint
    fillRect*: proc (a1: LCUI_CanvasContext; a2: cint; a3: cint; a4: cint; a5: cint) {.cdecl.}
    clearRect*: proc (a1: LCUI_CanvasContext; a2: cint; a3: cint; a4: cint; a5: cint) {.
        cdecl.}
    release*: proc (a1: LCUI_CanvasContext) {.cdecl.}


proc canvasGetContext*(w: LCUI_Widget): LCUI_CanvasContext {.lcui,
    importc: "Canvas_GetContext".}
proc addCanvas*() {.lcui, importc: "LCUIWidget_AddCanvas".}
##  LCUI_END_HEADER
