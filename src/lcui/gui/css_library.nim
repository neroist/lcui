##
##  css_library.h -- CSS library operation module.
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

##  LCUI_BEGIN_HEADER
##  clang-format off

import ../lcui

include ../incl

const
  MAX_SELECTOR_LEN* = 1024
  MAX_SELECTOR_DEPTH* = 32

##  样式属性名

type
  LCUI_StyleKeyName* = enum     ##  position start
    keyLeft, keyRight, keyTop, keyBottom, keyPosition, ##  position end
                                                  ##  display start
    keyVisibility, keyDisplay, ##  display end
    keyZIndex, keyOpacity, keyBoxSizing, keyWidth, keyHeight, keyMinWidth,
    keyMinHeight, keyMaxWidth, keyMaxHeight, ##  margin start
    keyMarginTop, keyMarginRight, keyMarginBottom, keyMarginLeft, ##  margin end
                                                              ##  padding start
    keyPaddingTop, keyPaddingRight, keyPaddingBottom, keyPaddingLeft, ##  padding end
    keyVerticalAlign,         ##  border start
    keyBorderTopWidth, keyBorderTopStyle, keyBorderTopColor, keyBorderRightWidth,
    keyBorderRightStyle, keyBorderRightColor, keyBorderBottomWidth,
    keyBorderBottomStyle, keyBorderBottomColor, keyBorderLeftWidth,
    keyBorderLeftStyle, keyBorderLeftColor, keyBorderTopLeftRadius,
    keyBorderTopRightRadius, keyBorderBottomLeftRadius, keyBorderBottomRightRadius, ##  border end
                                                                                 ##  background start
    keyBackgroundColor, keyBackgroundImage, keyBackgroundSize,
    keyBackgroundSizeWidth, keyBackgroundSizeHeight, keyBackgroundRepeat,
    keyBackgroundRepeatX, keyBackgroundRepeatY, keyBackgroundPosition,
    keyBackgroundPositionX, keyBackgroundPositionY, keyBackgroundOrigin, ##  background end
                                                                      ##  box shadow start
    keyBoxShadowX, keyBoxShadowY, keyBoxShadowSpread, keyBoxShadowBlur, keyBoxShadowColor, ##  box shadow end
                                                                                      ##  flex style start
    keyFlexBasis, keyFlexGrow, keyFlexShrink, keyFlexDirection, keyFlexWrap,
    keyJustifyContent, keyAlignContent, keyAlignItems, ##  flex style end
    keyPointerEvents, keyFocusable, STYLE_KEY_TOTAL


const
  keyFlexStyleStart* = keyFlexBasis
  keyFlexStyleEnd* = keyAlignContent
  keyPositionStart* = keyLeft
  keyPositionEnd* = keyPosition
  keyMarginStart* = keyMarginTop
  keyMarginEnd* = keyMarginLeft
  keyPaddingStart* = keyPaddingTop
  keyPaddingEnd* = keyPaddingLeft
  keyBorderStart* = keyBorderTopWidth
  keyBorderEnd* = keyBorderBottomRightRadius
  keyBackgroundStart* = keyBackgroundColor
  keyBackgroundEnd* = keyBackgroundOrigin
  keyBoxShadowStart* = keyBoxShadowX
  keyBoxShadowEnd* = keyBoxShadowColor

type
  LCUI_StyleSheetRec* {.bycopy.} = object
    sheet*: LCUI_Style
    length*: cint

  LCUI_StyleSheet* = ptr LCUI_StyleSheetRec
  LCUI_CachedStyleSheet* = ptr LCUI_StyleSheetRec
  LCUI_StyleListRec* = LinkedList
  LCUI_StyleList* = LinkedList
  LCUI_StyleListNodeRec* {.bycopy.} = object
    key*: cint
    style*: LCUI_StyleRec
    node*: LinkedListNode

  LCUI_StyleListNode* = ptr LCUI_StyleListNodeRec

##  选择器结点结构

type
  LCUI_SelectorNodeRec* {.bycopy.} = object
    id*: cstring
    ## < ID
    `type`*: cstring
    ## < 类型名称
    classes*: cstringArray
    ## < 样式类列表
    status*: cstringArray
    ## < 状态列表
    fullname*: cstring
    ## < 全名，由 id、type、classes、status 组合而成
    rank*: cint
    ## < 权值

  LCUI_SelectorNode* = ptr LCUI_SelectorNodeRec

##  选择器结构

type
  LCUI_SelectorRec* {.bycopy.} = object
    rank*: cint
    ## < 权值，决定优先级
    batchNum*: cint
    ## < 批次号
    length*: cint
    ## < 选择器结点长度
    hash*: cuint
    ## < 哈希值
    nodes*: ptr LCUI_SelectorNode
    ## < 选择器结点列表

  LCUI_Selector* = ptr LCUI_SelectorRec

##  clang-format on

template lCUI_FindStyleSheet*(s, L: untyped): untyped =
  lCUI_FindStyleSheetFromGroup(0, nil, s, L)

template styleSheetGetStyle*(s, k: untyped): untyped =
  addr(((s).sheet[k]))

proc destroyStyle*(s: LCUI_Style) {.lcui, importc: "DestroyStyle".}
proc mergeStyle*(dst: LCUI_Style; src: LCUI_Style) {.lcui, importc: "MergeStyle".}
proc styleList*(): LCUI_StyleList {.lcui, importc: "StyleList".}
proc styleListGetNode*(list: LCUI_StyleList; key: cint): LCUI_StyleListNode {.lcui,
    importc: "StyleList_GetNode".}
proc styleListRemoveNode*(list: LCUI_StyleList; key: cint): cint {.lcui,
    importc: "StyleList_RemoveNode".}
proc styleListAddNode*(list: LCUI_StyleList; key: cint): LCUI_StyleListNode {.lcui,
    importc: "StyleList_AddNode".}
proc styleListDelete*(list: LCUI_StyleList) {.lcui, importc: "StyleList_Delete".}
proc styleSheet*(): LCUI_StyleSheet {.lcui, importc: "StyleSheet".}
proc styleSheetClear*(ss: LCUI_StyleSheet) {.lcui, importc: "StyleSheet_Clear".}
proc styleSheetDelete*(ss: LCUI_StyleSheet) {.lcui, importc: "StyleSheet_Delete".}
proc styleSheetMerge*(dest: LCUI_StyleSheet; src: ptr LCUI_StyleSheetRec): cint {.
    lcui, importc: "StyleSheet_Merge".}
proc styleSheetMergeList*(ss: LCUI_StyleSheet; list: LCUI_StyleList): cint {.lcui,
    importc: "StyleSheet_MergeList".}
proc styleSheetReplace*(dest: LCUI_StyleSheet; src: ptr LCUI_StyleSheetRec): cint {.
    lcui, importc: "StyleSheet_Replace".}
proc selector*(selector: cstring): LCUI_Selector {.lcui, importc: "Selector".}
proc selectorCopy*(selector: LCUI_Selector): LCUI_Selector {.lcui,
    importc: "Selector_Copy".}
proc selectorAppendNode*(selector: LCUI_Selector; node: LCUI_SelectorNode): cint {.
    lcui, importc: "Selector_AppendNode".}
proc selectorUpdate*(s: LCUI_Selector) {.lcui, importc: "Selector_Update".}
proc selectorDelete*(s: LCUI_Selector) {.lcui, importc: "Selector_Delete".}
proc selectorNodeGetNames*(sn: LCUI_SelectorNode; names: ptr LinkedList): cint {.lcui,
    importc: "SelectorNode_GetNames".}
proc selectorNodeUpdate*(node: LCUI_SelectorNode): cint {.lcui,
    importc: "SelectorNode_Update".}
proc selectorNodeDelete*(node: LCUI_SelectorNode) {.lcui,
    importc: "SelectorNode_Delete".}
##
##  匹配选择器节点
##  左边的选择器必须包含右边的选择器的所有属性。
##

#proc selectorNodeMatch*(sn1: LCUI_SelectorNode; sn2: LCUI_SelectorNode): Lcui_Bool {.
#    lcui, importc: "SelectorNode_Match".}
proc putStyleSheet*(selector: LCUI_Selector; inSs: LCUI_StyleSheet;
                        space: cstring): cint {.lcui, importc: "LCUI_PutStyleSheet".}
##
##  从指定组中查找样式表
##  @param[in] group 组号
##  @param[in] name 选择器结点名称，若为 NULL，则根据选择器结点生成名称
##  @param[in] s 选择器
##  @param[out] list 找到的样式表列表
##

proc findStyleSheetFromGroup*(group: cint; name: cstring; s: LCUI_Selector;
                                  list: ptr LinkedList): cint {.lcui,
    importc: "LCUI_FindStyleSheetFromGroup".}
proc getCachedStyleSheet*(s: LCUI_Selector): LCUI_CachedStyleSheet {.lcui,
    importc: "LCUI_GetCachedStyleSheet".}
proc getStyleSheet*(s: LCUI_Selector; outSs: LCUI_StyleSheet) {.lcui,
    importc: "LCUI_GetStyleSheet".}
proc printStyleSheetsBySelector*(s: LCUI_Selector) {.lcui,
    importc: "LCUI_PrintStyleSheetsBySelector".}
proc setStyleName*(key: cint; name: cstring): cint {.lcui,
    importc: "LCUI_SetStyleName".}
proc addCSSPropertyName*(name: cstring): cint {.lcui,
    importc: "LCUI_AddCSSPropertyName".}
proc addStyleValue*(key: cint; name: cstring): cint {.lcui,
    importc: "LCUI_AddStyleValue".}
proc getStyleValue*(str: cstring): cint {.lcui, importc: "LCUI_GetStyleValue".}
proc getStyleValueName*(val: cint): cstring {.lcui,
    importc: "LCUI_GetStyleValueName".}
proc getStyleName*(key: cint): cstring {.lcui, importc: "LCUI_GetStyleName".}
proc getStyleTotal*(): cint {.lcui, importc: "LCUI_GetStyleTotal".}
proc printStyleSheet*(ss: LCUI_StyleSheet) {.lcui,
    importc: "LCUI_PrintStyleSheet".}
proc printSelector*(selector: LCUI_Selector) {.lcui,
    importc: "LCUI_PrintSelector".}
proc printCSSLibrary*() {.lcui, importc: "LCUI_PrintCSSLibrary".}
proc initCSSLibrary*() {.lcui, importc: "LCUI_InitCSSLibrary".}
proc freeCSSLibrary*() {.lcui, importc: "LCUI_FreeCSSLibrary".}
##  LCUI_END_HEADER
