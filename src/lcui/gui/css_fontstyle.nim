##
##  css_fontstyle.h -- CSS font style parse and operation set.
##
##  Copyright (c) 2018-2019, Liu chao <lc-soft@live.cn> All rights reserved.
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

import ../lcui, ../font, css_library

include ../incl

##  clang-format on

type
  LCUI_CSSFontStyleKey* = enum
    keyColor, keyFontSize, keyFontStyle, keyFontWeight, keyFontFamily, keyLineHeight,
    keyTextAlign, keyContent, keyWhiteSpace, TOTAL_FONT_STYLE_KEY


type
  LCUI_CSSFontStyleRec* {.bycopy.} = object
    fontSize*: cint
    lineHeight*: cint
    fontIds*: ptr cint
    fontFamily*: cstring
    content*: WideCString
    color*: LCUI_Color
    fontStyle*: LCUI_FontStyle
    fontWeight*: LCUI_FontWeight
    textAlign*: LCUI_StyleValue
    whiteSpace*: LCUI_StyleValue

  LCUI_CSSFontStyle* = ptr LCUI_CSSFontStyleRec

template widgetSetFontStyle*(w, k, v, t: untyped): void =
  while true:
    var key: cint = lCUI_GetFontStyleKey(k)
    widgetSetStyle(w, key, v, t)
    if not 0:
      break

##  clang-format off

proc getFontStyleKey*(key: cint): cint {.lcui, importc: "LCUI_GetFontStyleKey".}
proc cssFontStyleInit*(fs: LCUI_CSSFontStyle) {.lcui, importc: "CSSFontStyle_Init".}
proc cssFontStyleDestroy*(fs: LCUI_CSSFontStyle) {.lcui,
    importc: "CSSFontStyle_Destroy".}
proc cssFontStyleIsEquals*(a: LCUI_CSSFontStyle; b: LCUI_CSSFontStyle): Lcui_Bool {.
    lcui, importc: "CSSFontStyle_IsEquals".}
proc cssFontStyleCompute*(fs: LCUI_CSSFontStyle; ss: LCUI_StyleSheet) {.lcui,
    importc: "CSSFontStyle_Compute".}
proc cssFontStyleGetTextStyle*(fs: LCUI_CSSFontStyle; ts: LCUI_TextStyle) {.lcui,
    importc: "CSSFontStyle_GetTextStyle".}
proc initCSSFontStyle*() {.lcui, importc: "LCUI_InitCSSFontStyle".}
proc freeCSSFontStyle*() {.lcui, importc: "LCUI_FreeCSSFontStyle".}
##  LCUI_END_HEADER

