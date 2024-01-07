##
##  textedit.c -- textedit widget, used to allow user edit text.
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

import ../../lcui, ../widget

include ../../incl

template textEditNew*(): untyped =
  widgetNew("textedit")

##  Enable style tag parser
proc textEditEnableStyleTag*(widget: LCUI_Widget; enable: Lcui_Bool) {.lcui,
    importc: "TextEdit_EnableStyleTag".}
proc textEditEnableMultiline*(widget: LCUI_Widget; enable: Lcui_Bool) {.lcui,
    importc: "TextEdit_EnableMultiline".}
proc textEditMoveCaret*(widget: LCUI_Widget; row: cint; col: cint) {.lcui,
    importc: "TextEdit_MoveCaret".}
##  清空文本内容

proc textEditClearText*(widget: LCUI_Widget) {.lcui, importc: "TextEdit_ClearText".}
##  获取文本内容

proc textEditGetTextW*(w: LCUI_Widget; start: csize_t; maxLen: csize_t; buf: WideCString): csize_t {.
    lcui, importc: "TextEdit_GetTextW".}
##  获取文本长度

proc textEditGetTextLength*(w: LCUI_Widget): csize_t {.lcui,
    importc: "TextEdit_GetTextLength".}
##  设置文本编辑框内的光标，指定是否闪烁、闪烁时间间隔

proc textEditSetCaretBlink*(w: LCUI_Widget; visible: Lcui_Bool; time: cint) {.lcui,
    importc: "TextEdit_SetCaretBlink".}
#proc textEditGetProperty*(w: LCUI_Widget; name: cstring): LCUI_Object {.lcui,
#    importc: "TextEdit_GetProperty".}
##  为文本框设置文本（宽字符版）

proc textEditSetTextW*(widget: LCUI_Widget; wstr: WideCString): cint {.lcui,
    importc: "TextEdit_SetTextW".}
proc textEditSetText*(widget: LCUI_Widget; utf8Str: cstring): cint {.lcui,
    importc: "TextEdit_SetText".}
##  为文本框追加文本（宽字符版）

proc textEditAppendTextW*(widget: LCUI_Widget; wstr: WideCString): cint {.lcui,
    importc: "TextEdit_AppendTextW".}
##  为文本框插入文本（宽字符版）

proc textEditInsertTextW*(widget: LCUI_Widget; wstr: WideCString): cint {.lcui,
    importc: "TextEdit_InsertTextW".}
##  设置占位符，当文本编辑框内容为空时显示占位符

proc textEditSetPlaceHolderW*(w: LCUI_Widget; wstr: WideCString): cint {.lcui,
    importc: "TextEdit_SetPlaceHolderW".}
proc textEditSetPlaceHolder*(w: LCUI_Widget; str: cstring): cint {.lcui,
    importc: "TextEdit_SetPlaceHolder".}
##  设置密码屏蔽符

proc textEditSetPasswordChar*(w: LCUI_Widget; ch: int16) {.lcui,
    importc: "TextEdit_SetPasswordChar".}
proc addTextEdit*() {.lcui, importc: "LCUIWidget_AddTextEdit".}
##  LCUI_END_HEADER
