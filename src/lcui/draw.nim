##
##  draw.h -- The graphics draw module of LCUI.
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

proc backgroundPaint*(bg: ptr LCUI_Background; box: ptr LCUI_Rect;
                     paint: LCUI_PaintContext) {.lcui, importc: "Background_Paint".}

proc borderCropContent*(border: ptr LCUI_Border; box: ptr LCUI_Rect;
                       paint: LCUI_PaintContext): cint {.lcui,
    importc: "Border_CropContent".}
proc borderPaint*(border: ptr LCUI_Border; box: ptr LCUI_Rect; paint: LCUI_PaintContext): cint {.
    lcui, importc: "Border_Paint".}

proc boxShadowGetCanvasRect*(shadow: ptr LCUI_BoxShadow; boxRect: ptr LCUI_Rect;
                            canvasRect: ptr LCUI_Rect) {.lcui,
    importc: "BoxShadow_GetCanvasRect".}
proc boxShadowPaint*(shadow: ptr LCUI_BoxShadow; box: ptr LCUI_Rect;
                    cententWidth: cint; contentHeight: cint;
                    paint: LCUI_PaintContext): cint {.lcui,
    importc: "BoxShadow_Paint".}

proc graphDrawHorizLine*(graph: ptr LCUI_Graph; color: LCUI_Color; size: cint;
                        start: LCUI_Pos; endX: cint) {.lcui,
    importc: "Graph_DrawHorizLine".}
proc graphDrawVertiLine*(graph: ptr LCUI_Graph; color: LCUI_Color; size: cint;
                        start: LCUI_Pos; endY: cint) {.lcui,
    importc: "Graph_DrawVertiLine".}