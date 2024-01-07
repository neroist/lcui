##
##  scrollbar.c -- LCUI's scrollbar widget
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


import ../widget

include ../../incl

type
  LCUI_ScrollBarDirection* = enum
    LCUI_SCROLLBAR_HORIZONTAL, LCUI_SCROLLBAR_VERTICAL


##  TODO: remove these macro in next major version

const
  SBD_HORIZONTAL* = Lcui_Scrollbar_Horizontal
  SBD_VERTICAL* = Lcui_Scrollbar_Vertical

proc scrollBarBindBox*(w: LCUI_Widget; box: LCUI_Widget) {.lcui,
    importc: "ScrollBar_BindBox".}
proc scrollBarBindTarget*(w: LCUI_Widget; layer: LCUI_Widget) {.lcui,
    importc: "ScrollBar_BindTarget".}
##  获取滚动条的位置

proc scrollBarGetPosition*(w: LCUI_Widget): cint {.lcui,
    importc: "ScrollBar_GetPosition".}
##  将与滚动条绑定的内容滚动至指定位置

proc scrollBarSetPosition*(w: LCUI_Widget; pos: cint): cint {.lcui,
    importc: "ScrollBar_SetPosition".}
##  设置滚动条的方向

proc scrollBarSetDirection*(w: LCUI_Widget; direction: LCUI_ScrollBarDirection) {.
    lcui, importc: "ScrollBar_SetDirection".}
proc addTScrollBar*() {.lcui, importc: "LCUIWidget_AddTScrollBar".}
##  LCUI_END_HEADER
