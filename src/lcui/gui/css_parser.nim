##
##  css_parser.h -- CSS parser module
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

import ../lcui, css_library

include ../incl

type
  LCUI_CSSParserTarget* = enum
    CSS_TARGET_NONE,          ## < 无
    CSS_TARGET_RULE_NAME,     ## < 规则名称
    CSS_TARGET_RULE_DATA,     ## < 规则数据
    CSS_TARGET_SELECTOR,      ## < 选择器
    CSS_TARGET_KEY,           ## < 属性名
    CSS_TARGET_VALUE,         ## < 属性值
    CSS_TARGET_COMMENT,       ## < 注释
    CSS_TARGET_TOTAL_NUM
  LCUI_CSSRule* = enum
    CSS_RULE_NONE, CSS_RULE_FONT_FACE, ## < @font-face
    CSS_RULE_IMPORT,          ## < @import
    CSS_RULE_MEDIA,           ## < @media
    CSS_RULE_TOTAL_NUM

type
  LCUI_CSSRuleParser* = ptr LCUI_CSSRuleParserRec
  LCUI_CSSParserContext* = ptr LCUI_CSSParserContextRec
  LCUI_CSSParserStyleContext* = ptr LCUI_CSSParserStyleContextRec
  LCUI_CSSParser* = ptr LCUI_CSSParserRec
  LCUI_CSSPropertyParser* = ptr LCUI_CSSPropertyParserRec
  LCUI_CSSParserCommentContext* = ptr LCUI_CSSParserCommentContextRec
  LCUI_CSSParserRuleContext* = ptr LCUI_CSSParserRuleContextRec
  LCUI_CSSParserFunction* = proc (ctx: LCUI_CSSParserContext): cint {.cdecl.}
  LCUI_CSSParserRec* {.bycopy.} = object
    parse*: LCUI_CSSParserFunction

  LCUI_CSSRuleParserRec* {.bycopy.} = object
    name*: array[32, char]
    data*: pointer
    begin*: LCUI_CSSParserFunction
    parse*: LCUI_CSSParserFunction

  LCUI_CSSParsers* = array[Css_Target_Total_Num, LCUI_CSSParserRec]
  LCUI_CSSRuleParsers* = array[Css_Rule_Total_Num, LCUI_CSSRuleParserRec]

  LCUI_CSSPropertyParserRec* {.bycopy.} = object
    key*: cint
    ## <
    ## 标识，在解析数据时可以使用它访问样式表中的自定义属性
    name*: cstring
    ## < 名称，对应 CSS 样式属性名称
    parse*: proc (a1: LCUI_CSSParserStyleContext; a2: cstring): cint {.cdecl.}

  LCUI_CSSParserStyleContextRec* {.bycopy.} = object
    dirname*: cstring
    ## < 当前所在的目录
    space*: cstring
    ## < 样式记录所属的空间
    styleHandler*: proc (a1: cint; a2: LCUI_Style; a3: pointer) {.cdecl.}
    styleHandlerArg*: pointer
    selectors*: LinkedList
    ## < 当前匹配到的选择器列表
    sheet*: LCUI_StyleSheet
    ## < 当前缓存的样式表
    parser*: LCUI_CSSPropertyParser
    ## < 当前找到的样式属性解析器

  LCUI_CSSParserCommentContextRec* {.bycopy.} = object
    isLineComment*: Lcui_Bool
    ## < 是否为单行注释
    prevTarget*: LCUI_CSSParserTarget
    ## < 保存的上一个目标，解析完注释后将还原成该目标

  LCUI_CSSParserRuleContextRec* {.bycopy.} = object
    state*: cint
    ## < 规则解析器的状态
    rule*: LCUI_CSSRule
    ## < 当前规则
    parsers*: LCUI_CSSRuleParsers
    ## < 规则解析器列表

  LCUI_CSSParserContextRec* {.bycopy.} = object
    pos*: cint
    ## < 缓存中的字符串的下标位置
    cur*: cstring
    ## < 用于遍历字符串的指针
    space*: cstring
    ## < 样式记录所属的空间
    buffer*: cstring
    ## < 缓存中的字符串
    bufferSize*: csize_t
    ## < 缓存区大小
    target*: LCUI_CSSParserTarget
    ## < 当前解析目标
    parsers*: LCUI_CSSParsers
    ## < 可供使用的解析器列表
    rule*: LCUI_CSSParserRuleContextRec
    style*: LCUI_CSSParserStyleContextRec
    comment*: LCUI_CSSParserCommentContextRec


proc getStyleValue*(str: cstring): cint {.lcui, importc: "LCUI_GetStyleValue".}
proc getStyleValueName*(val: cint): cstring {.lcui,
    importc: "LCUI_GetStyleValueName".}
proc getStyleName*(key: cint): cstring {.lcui, importc: "LCUI_GetStyleName".}
##  初始化 LCUI 的 CSS 代码解析功能

proc initCSSParser*() {.lcui, importc: "LCUI_InitCSSParser".}
proc cssStyleParserSetCSSProperty*(ctx: LCUI_CSSParserStyleContext; key: cint;
                                  s: LCUI_Style) {.lcui,
    importc: "CSSStyleParser_SetCSSProperty".}
proc getCSSPropertyParser*(name: cstring): LCUI_CSSPropertyParser {.lcui,
    importc: "LCUI_GetCSSPropertyParser".}
##  从文件中载入CSS样式数据，并导入至样式库中

proc loadCSSFile*(filepath: cstring): cint {.lcui, importc: "LCUI_LoadCSSFile".}
##  从字符串中载入CSS样式数据，并导入至样式库中

proc loadCSSString*(str: cstring; space: cstring): csize_t {.lcui,
    importc: "LCUI_LoadCSSString".}
proc cssParserBegin*(bufferSize: csize_t; space: cstring): LCUI_CSSParserContext {.
    lcui, importc: "CSSParser_Begin".}
proc cssParserEndParseRuleData*(ctx: LCUI_CSSParserContext) {.lcui,
    importc: "CSSParser_EndParseRuleData".}
proc cssParserEndBuffer*(ctx: LCUI_CSSParserContext) {.lcui,
    importc: "CSSParser_EndBuffer".}
proc cssParserEnd*(ctx: LCUI_CSSParserContext) {.lcui, importc: "CSSParser_End".}
proc cssParserBeginParseComment*(ctx: LCUI_CSSParserContext): cint {.lcui,
    importc: "CSSParser_BeginParseComment".}
proc freeCSSParser*() {.lcui, importc: "LCUI_FreeCSSParser".}
##  注册新的属性和对应的属性值解析器

proc addCSSPropertyParser*(sp: LCUI_CSSPropertyParser): cint {.lcui,
    importc: "LCUI_AddCSSPropertyParser".}
##  LCUI_END_HEADER
