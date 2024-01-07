##
##  graph.h -- The base graphics handling module for LCUI
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

##
##  Pixel over operator with alpha channel
##  See more: https://en.wikipedia.org/wiki/Alpha_compositing
##

proc overPixel*(dst: ptr Lcui_Argb; src: ptr Lcui_Argb) {.lcui,
    importc: "LCUI_OverPixel", inline.}

proc graphPrintInfo*(graph: ptr LCUI_Graph) {.lcui, importc: "Graph_PrintInfo".}
proc graphInit*(graph: ptr LCUI_Graph) {.lcui, importc: "Graph_Init".}
proc rgb*(r: UcharT; g: UcharT; b: UcharT): LCUI_Color {.lcui, importc: "RGB".}
proc argb*(a: UcharT; r: UcharT; g: UcharT; b: UcharT): LCUI_Color {.lcui, importc: "ARGB".}
proc pixelsFormat*(inPixels: ptr UcharT; inColorType: cint; outPixels: ptr UcharT;
                  outColorType: cint; pixelCount: csize_t) {.lcui,
    importc: "PixelsFormat".}
##  改变色彩类型

proc graphSetColorType*(graph: ptr LCUI_Graph; colorType: cint): cint {.lcui,
    importc: "Graph_SetColorType".}
proc graphCreate*(graph: ptr LCUI_Graph; width: cuint; height: cuint): cint {.lcui,
    importc: "Graph_Create".}
proc graphCopy*(des: ptr LCUI_Graph; src: ptr LCUI_Graph) {.lcui, importc: "Graph_Copy".}
proc graphFree*(graph: ptr LCUI_Graph) {.lcui, importc: "Graph_Free".}
##
##  为图像创建一个引用
##  @param self 用于存放图像引用的缓存区
##  @param source 引用的源图像
##  &param rect 引用的区域，若为NULL，则引用整个图像
##

proc graphQuote*(self: ptr LCUI_Graph; source: ptr LCUI_Graph; rect: ptr LCUI_Rect): cint {.
    lcui, importc: "Graph_Quote".}
##
##  为图像创建一个只读引用
##  @param self 用于存放图像引用的缓存区
##  @param source 引用的源图像
##  &param rect 引用的区域，若为NULL，则引用整个图像
##

proc graphQuoteReadOnly*(self: ptr LCUI_Graph; source: ptr LCUI_Graph;
                        rect: ptr LCUI_Rect): cint {.lcui,
    importc: "Graph_QuoteReadOnly".}
proc graphIsValid*(graph: ptr LCUI_Graph): uint8 {.lcui, importc: "Graph_IsValid".}
proc graphGetValidRect*(graph: ptr LCUI_Graph; rect: ptr LCUI_Rect) {.lcui,
    importc: "Graph_GetValidRect".}
proc graphSetAlphaBits*(graph: ptr LCUI_Graph; a: ptr UcharT; size: csize_t): cint {.
    lcui, importc: "Graph_SetAlphaBits".}
proc graphSetRedBits*(graph: ptr LCUI_Graph; r: ptr UcharT; size: csize_t): cint {.lcui,
    importc: "Graph_SetRedBits".}
proc graphSetGreenBits*(graph: ptr LCUI_Graph; g: ptr UcharT; size: csize_t): cint {.
    lcui, importc: "Graph_SetGreenBits".}
proc graphSetBlueBits*(graph: ptr LCUI_Graph; b: ptr UcharT; size: csize_t): cint {.lcui,
    importc: "Graph_SetBlueBits".}
proc graphZoom*(graph: ptr LCUI_Graph; buff: ptr LCUI_Graph; keepScale: uint8;
               width: cint; height: cint): cint {.lcui, importc: "Graph_Zoom".}
proc graphZoomBilinear*(graph: ptr LCUI_Graph; buff: ptr LCUI_Graph; keepScale: uint8;
                       width: cint; height: cint): cint {.lcui,
    importc: "Graph_ZoomBilinear".}
proc graphCut*(graph: ptr LCUI_Graph; rect: LCUI_Rect; buff: ptr LCUI_Graph): cint {.
    lcui, importc: "Graph_Cut".}
proc graphHorizFlip*(graph: ptr LCUI_Graph; buff: ptr LCUI_Graph): cint {.lcui,
    importc: "Graph_HorizFlip".}
proc graphVertiFlip*(graph: ptr LCUI_Graph; buff: ptr LCUI_Graph): cint {.lcui,
    importc: "Graph_VertiFlip".}
##
##  用颜色填充一块区域
##  @param[in][out] graph 需要填充的图层
##  @param[in] color 颜色
##  @param[in] rect 区域，若值为 NULL，则填充整个图层
##  @param[in] with_alpha 是否需要处理alpha通道
##

proc graphFillRect*(graph: ptr LCUI_Graph; color: LCUI_Color; rect: ptr LCUI_Rect;
                   withAlpha: uint8): cint {.lcui, importc: "Graph_FillRect".}
proc graphFillAlpha*(graph: ptr LCUI_Graph; alpha: UcharT): cint {.lcui,
    importc: "Graph_FillAlpha".}
proc graphTile*(buff: ptr LCUI_Graph; graph: ptr LCUI_Graph; replace: uint8;
               withAlpha: uint8): cint {.lcui, importc: "Graph_Tile".}
##
##  混合两张图层
##  将前景图混合到背景图上
##  @param[in][out] back 背景图层
##  @param[in] fore 前景图层
##  @param[in] left 前景图层的左边距
##  @param[in] top 前景图层的上边距
##  @param[in] with_alpha 是否需要处理alpha通道
##

proc graphMix*(back: ptr LCUI_Graph; fore: ptr LCUI_Graph; left: cint; top: cint;
              withAlpha: uint8): cint {.lcui, importc: "Graph_Mix".}
proc graphReplace*(back: ptr LCUI_Graph; fore: ptr LCUI_Graph; left: cint; top: cint): cint {.
    lcui, importc: "Graph_Replace".}
##  LCUI_END_HEADER
##  #include <LCUI/draw.h>
