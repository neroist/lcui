##
##  surface.h -- Graphic presentation layer.
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
## #ifndef LCUI_SURFACE_H
## #define LCUI_SURFACE_H
##
## LCUI_BEGIN_HEADER
##
## #define RENDER_MODE_BIT_BLT	0
## #define RENDER_MODE_STRETCH_BLT 1
##
## #ifdef LCUI_SURFACE_C
## typedef struct LCUI_SurfaceRec_ * LCUI_Surface;
## #else

# import std/widestrs

import lcui

include incl

type
  LCUI_Surface* = pointer

## #endif
##  关闭 surface

proc surfaceClose*(surface: LCUI_Surface) {.lcui, importc: "Surface_Close".}
##  直接销毁 surface

proc surfaceDestroy*(surface: LCUI_Surface) {.lcui, importc: "Surface_Destroy".}
##  新建一个 Surface

proc surfaceNew*(): LCUI_Surface {.lcui, importc: "Surface_New".}
proc surfaceIsReady*(surface: LCUI_Surface): uint8 {.lcui,
    importc: "Surface_IsReady".}
proc surfaceMove*(surface: LCUI_Surface; x: cint; y: cint) {.lcui,
    importc: "Surface_Move".}
proc surfaceGetWidth*(surface: LCUI_Surface): cint {.lcui,
    importc: "Surface_GetWidth".}
proc surfaceGetHeight*(surface: LCUI_Surface): cint {.lcui,
    importc: "Surface_GetHeight".}
proc surfaceResize*(surface: LCUI_Surface; w: cint; h: cint) {.lcui,
    importc: "Surface_Resize".}
proc surfaceSetCaptionW*(surface: LCUI_Surface; str: cstring) {.lcui, # str: WideCString
    importc: "Surface_SetCaptionW".}
proc surfaceShow*(surface: LCUI_Surface) {.lcui, importc: "Surface_Show".}
proc surfaceHide*(surface: LCUI_Surface) {.lcui, importc: "Surface_Hide".}
proc surfaceGetHandle*(surface: LCUI_Surface): pointer {.lcui,
    importc: "Surface_GetHandle".}
##  设置 Surface 的渲染模式

proc surfaceSetRenderMode*(surface: LCUI_Surface; mode: cint) {.lcui,
    importc: "Surface_SetRenderMode".}
##  更新 surface，应用缓存的变更

proc surfaceUpdate*(surface: LCUI_Surface) {.lcui, importc: "Surface_Update".}
##
##  准备绘制 Surface 中的内容
##  @param[in] surface	目标 surface
##  @param[in] rect	需进行绘制的区域，若为NULL，则绘制整个 surface
##  @return		返回绘制上下文句柄
##

proc surfaceBeginPaint*(surface: LCUI_Surface; rect: ptr LCUI_Rect): LCUI_PaintContext {.
    lcui, importc: "Surface_BeginPaint".}

##
##  结束对 Surface 的绘制操作
##  @param[in] surface	目标 surface
##  @param[in] paint_ctx	绘制上下文句柄
##

proc surfaceEndPaint*(surface: LCUI_Surface; paint: LCUI_PaintContext) {.lcui,
    importc: "Surface_EndPaint".}

##  将帧缓存中的数据呈现至Surface的窗口内

proc surfacePresent*(surface: LCUI_Surface) {.lcui, importc: "Surface_Present".}
##  LCUI_END_HEADER
##  #endif
