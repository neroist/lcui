##
##  widget.h -- GUI widget APIs.
##
##  Copyright (c) 2018-2020, Liu chao <lc-soft@live.cn> All rights reserved.
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

import std/widestrs

import ../lcui, css_library

include ../incl

type
  LCUI_WidgetStyle* {.bycopy.} = object
    visible*: Lcui_Bool
    focusable*: Lcui_Bool
    widthSizing*: LCUI_SizingRule
    heightSizing*: LCUI_SizingRule
    minWidth*: cfloat
    minHeight*: cfloat
    maxWidth*: cfloat
    maxHeight*: cfloat
    left*: cfloat
    top*: cfloat
    right*: cfloat
    bottom*: cfloat
    zIndex*: cint
    opacity*: cfloat
    position*: LCUI_StyleValue
    display*: LCUI_StyleValue
    boxSizing*: LCUI_StyleValue
    verticalAlign*: LCUI_StyleValue
    border*: LCUI_BorderStyle
    shadow*: LCUI_BoxShadowStyle
    background*: LCUI_BackgroundStyle
    flex*: LCUI_FlexBoxLayoutStyle
    pointerEvents*: cint

  LCUI_WidgetActualStyleRec* {.bycopy.} = object
    x*: cfloat
    y*: cfloat
    canvasBox*: LCUI_Rect
    borderBox*: LCUI_Rect
    paddingBox*: LCUI_Rect
    contentBox*: LCUI_Rect
    border*: LCUI_Border
    shadow*: LCUI_BoxShadow
    background*: LCUI_Background

  LCUI_WidgetActualStyle* = ptr LCUI_WidgetActualStyleRec

##  部件任务类型，按照任务的依赖顺序排列

type
  LCUI_WidgetTaskType* = enum
    LCUI_WTASK_REFRESH_STYLE,           ## < 刷新部件全部样式
    LCUI_WTASK_UPDATE_STYLE,            ## < 更新部件自定义样式
    LCUI_WTASK_TITLE, LCUI_WTASK_PROPS, ## < 更新一些属性
    LCUI_WTASK_BOX_SIZING, LCUI_WTASK_PADDING, LCUI_WTASK_MARGIN,
    LCUI_WTASK_VISIBLE, LCUI_WTASK_DISPLAY, LCUI_WTASK_FLEX, LCUI_WTASK_SHADOW,
    LCUI_WTASK_BORDER, LCUI_WTASK_BACKGROUND, LCUI_WTASK_POSITION,
    LCUI_WTASK_RESIZE, LCUI_WTASK_ZINDEX, LCUI_WTASK_OPACITY, LCUI_WTASK_REFLOW,
    LCUI_WTASK_USER, LCUI_WTASK_TOTAL_NUM


##  See more: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Box_Model

type
  LCUI_WidgetBoxModelRec* {.bycopy.} = object
    content*: LCUI_RectF
    padding*: LCUI_RectF
    border*: LCUI_RectF
    canvas*: LCUI_RectF
    outer*: LCUI_RectF

  LCUI_WidgetBoxModel* = ptr LCUI_WidgetBoxModelRec
  LCUI_WidgetTaskRec* {.bycopy.} = object
    ##  Should update for self?
    forSelf*: Lcui_Bool
    ##  Should update for children?
    forChildren*: Lcui_Bool
    ##  Should skip the property sync of bound surface?
    skipSurfacePropsSync*: Lcui_Bool
    ##  States of tasks
    states*: array[Lcui_Wtask_Total_Num, Lcui_Bool]


##  部件状态

type
  LCUI_WidgetState* = enum
    LCUI_WSTATE_CREATED = 0, LCUI_WSTATE_UPDATED, LCUI_WSTATE_LAYOUTED,
    LCUI_WSTATE_READY, LCUI_WSTATE_NORMAL, LCUI_WSTATE_DELETED
  LCUI_Widget* = ptr LCUI_WidgetRec
  LCUI_WidgetPrototype* = ptr LCUI_WidgetPrototypeRec
  LCUI_WidgetPrototypeC* = ptr LCUI_WidgetPrototypeRec
  LCUI_WidgetFunction* = proc (a1: LCUI_Widget) {.cdecl.}
  LCUI_WidgetTaskHandler* = proc (a1: LCUI_Widget; a2: cint) {.cdecl.}
  LCUI_WidgetSizeGetter* = proc (a1: LCUI_Widget; a2: ptr cfloat; a3: ptr cfloat;
                              a4: LCUI_LayoutRule) {.cdecl.}
  LCUI_WidgetSizeSetter* = proc (a1: LCUI_Widget; a2: cfloat;
      a3: cfloat) {.cdecl.}
  LCUI_WidgetAttrSetter* = proc (a1: LCUI_Widget; a2: cstring;
      a3: cstring) {.cdecl.}
  LCUI_WidgetTextSetter* = proc (a1: LCUI_Widget; a2: cstring) {.cdecl.}
  LCUI_WidgetPropertyBinder* = proc (a1: LCUI_Widget; a2: cstring;
      a3: LCUI_Object) {.
      cdecl.}
  LCUI_WidgetPainter* = proc (a1: LCUI_Widget; a2: LCUI_PaintContext;
                           a3: LCUI_WidgetActualStyle) {.cdecl.}
  LCUI_WidgetPrototypeRec* {.bycopy.} = object
    name*: cstring
    init*: LCUI_WidgetFunction
    refresh*: LCUI_WidgetFunction
    destroy*: LCUI_WidgetFunction
    update*: LCUI_WidgetFunction
    runtask*: LCUI_WidgetTaskHandler
    setattr*: LCUI_WidgetAttrSetter
    settext*: LCUI_WidgetTextSetter
    bindprop*: LCUI_WidgetPropertyBinder
    autosize*: LCUI_WidgetSizeGetter
    resize*: LCUI_WidgetSizeSetter
    paint*: LCUI_WidgetPainter
    proto*: LCUI_WidgetPrototype

  LCUI_WidgetDataEntryRec* {.bycopy.} = object
    data*: pointer
    proto*: LCUI_WidgetPrototype

  LCUI_WidgetData* {.bycopy.} = object
    length*: cuint
    list*: ptr LCUI_WidgetDataEntryRec

  LCUI_WidgetRulesRec* {.bycopy.} = object
    ##
    ##  Suspend update if the current widget is not visible or is
    ##  completely covered by other widgets
    ##
    onlyOnVisible*: Lcui_Bool
    ##
    ##  First update the children in the visible area
    ##  If your widget has a lot of children and you want to see the
    ##  children who are currently seeing the priority update, we recommend
    ##  enabling this rule.
    ##
    firstUpdateVisibleChildren*: Lcui_Bool
    ##
    ##  Cache the stylesheets of children to improve the query speed of
    ##  the stylesheet.
    ##  If this rule is enabled, we recommend that you manually call
    ##  Widget_GenerateHash() to generate a hash value for the children
    ##  of the widget.
    ##
    cacheChildrenStyle*: Lcui_Bool
    ##  Refresh the style of all child widgets if the status has changed
    ignoreStatusChange*: Lcui_Bool
    ##  Refresh the style of all child widgets if the classes has changed
    ignoreClassesChange*: Lcui_Bool
    ##
    ##  Maximum number of children updated at each update
    ##  values:
    ##  -1 - Update all children at once
    ##  0  - Automatically calculates the appropriate maximum number
    ##  N  - Custom maximum number
    ##
    maxUpdateChildrenCount*: cint
    ##  Limit the number of children rendered
    maxRenderChildrenCount*: cuint
    ##  A callback function on update progress
    onUpdateProgress*: proc (a1: LCUI_Widget; a2: csize_t) {.cdecl.}

  LCUI_WidgetRules* = ptr LCUI_WidgetRulesRec

  INNER_C_UNION_widget_base_4* {.bycopy, union.} = object
    string*: cstring
    data*: pointer

  INNER_C_STRUCT_widget_base_3* {.bycopy.} = object
    `type`*: cint
    destructor*: proc (a1: pointer) {.cdecl.}
    anoWidgetBase5*: INNER_C_UNION_widget_base_4

  LCUI_WidgetRulesDataRec* {.bycopy.} = object
    rules*: LCUI_WidgetRulesRec
    #styleCache*: ptr Dict
    defaultMaxUpdateCount*: csize_t
    progress*: csize_t

  LCUI_WidgetRulesData* = ptr LCUI_WidgetRulesDataRec
  LCUI_WidgetAttributeRec* {.bycopy.} = object
    name*: cstring
    value*: INNER_C_STRUCT_widget_base_3

  LCUI_WidgetAttribute* = ptr LCUI_WidgetAttributeRec
  LCUI_InvalidAreaType* = enum
    LCUI_INVALID_AREA_TYPE_NONE, LCUI_INVALID_AREA_TYPE_CUSTOM,
    LCUI_INVALID_AREA_TYPE_PADDING_BOX, LCUI_INVALID_AREA_TYPE_BORDER_BOX,
    LCUI_INVALID_AREA_TYPE_CANVAS_BOX
  LCUI_WidgetRec* {.bycopy.} = object
    hash*: cuint
    state*: LCUI_WidgetState
    id*: cstring
    `type`*: cstring
    #classes*: StrlistT
    #status*: StrlistT
    title*: WideCString # ptr WcharT
                        #attributes*: ptr Dict
    disabled*: Lcui_Bool
    eventBlocked*: Lcui_Bool
    ##
    ##  Coordinates calculated by the layout system
    ##  The position of the rectangular boxes is calculated based on it
    ##
    layoutX*: cfloat
    layoutY*: cfloat
    ##
    ##  Geometric parameters (readonly)
    ##  Their values come from the box.border
    ##
    x*: cfloat
    y*: cfloat
    width*: cfloat
    height*: cfloat
    ##
    ##  A box’s “ideal” size in a given axis when given infinite available space.
    ##  See more: https://drafts.csswg.org/css-sizing-3/#max-content
    ##
    maxContentWidth*: cfloat
    maxContentHeight*: cfloat
    padding*: LCUI_Rect2F
    margin*: LCUI_Rect2F
    box*: LCUI_WidgetBoxModelRec
    style*: LCUI_StyleSheet
    customStyle*: LCUI_StyleList
    inheritedStyle*: LCUI_CachedStyleSheet
    computedStyle*: LCUI_WidgetStyle
    ##  Some data bound to the prototype
    data*: LCUI_WidgetData
    ##
    ##  Prototype chain
    ##  It is used to implement the inheritance of widgets,
    ##  Just like prototype chain in JavaScript
    ##
    proto*: LCUI_WidgetPrototypeC
    ##  Update task context
    task*: LCUI_WidgetTaskRec
    rules*: LCUI_WidgetRules
    trigger*: LCUI_EventTrigger
    ##  Invalid area (Dirty Rectangle)
    invalidArea*: LCUI_RectF
    invalidAreaType*: LCUI_InvalidAreaType
    hasChildInvalidArea*: Lcui_Bool
    ##  Parent widget
    parent*: LCUI_Widget
    ##  List of child widgets
    children*: LinkedList
    ##  List of child widgets in descending order by z-index
    childrenShow*: LinkedList
    ##
    ##  Position in the parent->children
    ##  this == LinkedList_Get(&this->parent->children, this.index)
    ##
    index*: csize_t
    ##
    ##  Node in the parent->children
    ##  &this->node == LinkedList_GetNode(&this->parent->children, this.index)
    ##
    node*: LinkedListNode
    ##  Node in the parent->children_shoa
    nodeShow*: LinkedListNode



##  clang-format on

proc isFlexLayoutStyleWorks*(w: LCUI_Widget): Lcui_Bool {.inline, lcui,
    importc: "Widget_IsFlexLayoutStyleWorks".}
proc computeXMetric*(w: LCUI_Widget; key: cint): cfloat {.lcui,
    importc: "Widget_ComputeXMetric".}
proc computeYMetric*(w: LCUI_Widget; key: cint): cfloat {.lcui,
    importc: "Widget_ComputeYMetric".}
proc HasAutoStyle*(w: LCUI_Widget; key: cint): Lcui_Bool {.lcui,
    importc: "Widget_HasAutoStyle".}
proc getRoot*(): LCUI_Widget {.lcui, importc: "LCUIWidget_GetRoot".}
proc getById*(idstr: cstring): LCUI_Widget {.lcui,
    importc: "LCUIWidget_GetById".}
##  Create a widget by prototype

proc newWithPrototype*(proto: LCUI_WidgetPrototypeC): LCUI_Widget {.lcui,
    importc: "LCUIWidget_NewWithPrototype".}
##  Create a widget by type name

proc new*(typeName: cstring): LCUI_Widget {.lcui,
    importc: "LCUIWidget_New".}
##  Execute destruction task

proc execDestroy*(w: LCUI_Widget) {.lcui, importc: "Widget_ExecDestroy".}
##  Mark a Widget needs to be destroyed

proc destroy*(w: LCUI_Widget) {.lcui, importc: "Widget_Destroy".}
proc getOffset*(w: LCUI_Widget; parent: LCUI_Widget; offsetX: ptr cfloat;
                     offsetY: ptr cfloat) {.lcui, importc: "Widget_GetOffset".}
proc top*(w: LCUI_Widget): cint {.lcui, importc: "Widget_Top".}
proc sortChildrenShow*(w: LCUI_Widget) {.lcui,
    importc: "Widget_SortChildrenShow".}
proc setTitleW*(w: LCUI_Widget; title: WideCString) {.lcui,
    importc: "Widget_SetTitleW".}
proc addState*(w: LCUI_Widget; state: LCUI_WidgetState) {.lcui,
    importc: "Widget_AddState".}
##  Check whether the widget is in the visible area

proc inVisibleArea*(w: LCUI_Widget): Lcui_Bool {.lcui,
    importc: "Widget_InVisibleArea".}
##  Set widget updating rules

proc setRules*(w: LCUI_Widget; rules: ptr LCUI_WidgetRulesRec): cint {.lcui,
    importc: "Widget_SetRules".}
##  Set widget content text

proc setText*(w: LCUI_Widget; text: cstring) {.lcui, importc: "Widget_SetText".}
##  Bind an object to a widget property, and the widget property is automatically
##  updated when the value of the object changes

proc bindProperty*(w: LCUI_Widget; name: cstring; value: LCUI_Object) {.lcui,
    importc: "Widget_BindProperty".}
proc updateBoxPosition*(w: LCUI_Widget) {.lcui,
    importc: "Widget_UpdateBoxPosition".}
proc updateCanvasBox*(w: LCUI_Widget) {.lcui,
    importc: "Widget_UpdateCanvasBox".}
proc updateBoxSize*(w: LCUI_Widget) {.lcui, importc: "Widget_UpdateBoxSize".}
proc clearTrash*(): csize_t {.lcui, importc: "LCUIWidget_ClearTrash".}
proc initBase*() {.lcui, importc: "LCUIWidget_InitBase".}
proc freeRoot*() {.lcui, importc: "LCUIWidget_FreeRoot".}
proc freeBase*() {.lcui, importc: "LCUIWidget_FreeBase".}
##  LCUI_END_HEADER

proc setAttributeEx*(w: LCUI_Widget; name: cstring; value: pointer;
                          valueType: cint;
                          valueDestructor: proc (
                              a1: pointer) {.cdecl.}): cint {.
    lcui, importc: "Widget_SetAttributeEx".}
proc setAttribute*(w: LCUI_Widget; name: cstring; value: cstring): cint {.lcui,
    importc: "Widget_SetAttribute".}
proc getAttribute*(w: LCUI_Widget; name: cstring): cstring {.lcui,
    importc: "Widget_GetAttribute".}
proc destroyAttributes*(w: LCUI_Widget) {.lcui,
    importc: "Widget_DestroyAttributes".}

proc destroyId*(w: LCUI_Widget): cint {.lcui, importc: "Widget_DestroyId".}
proc setId*(w: LCUI_Widget; idstr: cstring): cint {.lcui,
    importc: "Widget_SetId".}

proc initIdLibrary*() {.lcui, importc: "LCUIWidget_InitIdLibrary".}
proc freeIdLibrary*() {.lcui, importc: "LCUIWidget_FreeIdLibrary".}

proc generateSelfHash*(w: LCUI_Widget) {.lcui,
    importc: "Widget_GenerateSelfHash".}
##  Generate hash values for a widget and its children

proc generateHash*(w: LCUI_Widget) {.lcui, importc: "Widget_GenerateHash".}
proc setHashList*(w: LCUI_Widget; hashList: ptr cuint; len: csize_t): csize_t {.
    lcui, importc: "Widget_SetHashList".}
proc getHashList*(w: LCUI_Widget; hashList: ptr cuint;
    maxlen: csize_t): csize_t {.
    lcui, importc: "Widget_GetHashList".}

proc addClass*(w: LCUI_Widget; className: cstring): cint {.lcui,
    importc: "Widget_AddClass".}
proc HasClass*(w: LCUI_Widget; className: cstring): Lcui_Bool {.lcui,
    importc: "Widget_HasClass".}
proc removeClass*(w: LCUI_Widget; className: cstring): cint {.lcui,
    importc: "Widget_RemoveClass".}
proc destroyClasses*(w: LCUI_Widget) {.lcui, importc: "Widget_DestroyClasses".}

proc addStatus*(w: LCUI_Widget; statusName: cstring): cint {.lcui,
    importc: "Widget_AddStatus".}
proc HasStatus*(w: LCUI_Widget; statusName: cstring): Lcui_Bool {.lcui,
    importc: "Widget_HasStatus".}
proc removeStatus*(w: LCUI_Widget; statusName: cstring): cint {.lcui,
    importc: "Widget_RemoveStatus".}
proc updateStatus*(widget: LCUI_Widget) {.lcui,
    importc: "Widget_UpdateStatus".}

template widgetIsVisible*(w: untyped): untyped =
  (w).computedStyle.visible

##  设置内边距

proc setPadding*(w: LCUI_Widget; top: cfloat; right: cfloat; bottom: cfloat;
                      left: cfloat) {.lcui, importc: "Widget_SetPadding".}
##  设置外边距

proc setMargin*(w: LCUI_Widget; top: cfloat; right: cfloat; bottom: cfloat;
                     left: cfloat) {.lcui, importc: "Widget_SetMargin".}
proc setBorderColor*(w: LCUI_Widget; color: LCUI_Color) {.lcui,
    importc: "Widget_SetBorderColor".}
proc setBorderWidth*(w: LCUI_Widget; width: cfloat) {.lcui,
    importc: "Widget_SetBorderWidth".}
proc setBorderStyle*(w: LCUI_Widget; style: cint) {.lcui,
    importc: "Widget_SetBorderStyle".}
##  设置边框样式

proc setBorder*(w: LCUI_Widget; width: cfloat; style: cint; clr: LCUI_Color) {.
    lcui, importc: "Widget_SetBorder".}
##  设置阴影样式

proc setBoxShadow*(w: LCUI_Widget; x: cfloat; y: cfloat; blur: cfloat;
                        color: LCUI_Color) {.lcui,
                            importc: "Widget_SetBoxShadow".}
##  移动部件位置

proc Move*(w: LCUI_Widget; left: cfloat; top: cfloat) {.lcui,
    importc: "Widget_Move".}
##  调整部件尺寸

proc resize*(w: LCUI_Widget; width: cfloat; height: cfloat) {.lcui,
    importc: "Widget_Resize".}
proc getStyle*(w: LCUI_Widget; key: cint): LCUI_Style {.lcui,
    importc: "Widget_GetStyle".}
proc unsetStyle*(w: LCUI_Widget; key: cint): cint {.lcui,
    importc: "Widget_UnsetStyle".}
proc getInheritedStyle*(w: LCUI_Widget; key: cint): LCUI_Style {.lcui,
    importc: "Widget_GetInheritedStyle".}
proc checkStyleBooleanValue*(w: LCUI_Widget; key: cint;
    value: Lcui_Bool): Lcui_Bool {.
    lcui, importc: "Widget_CheckStyleBooleanValue".}
proc checkStyleValid*(w: LCUI_Widget; key: cint): Lcui_Bool {.lcui,
    importc: "Widget_CheckStyleValid".}
proc setVisibility*(w: LCUI_Widget; value: cstring) {.lcui,
    importc: "Widget_SetVisibility".}
proc setVisible*(w: LCUI_Widget) {.lcui, importc: "Widget_SetVisible".}
proc setHidden*(w: LCUI_Widget) {.lcui, importc: "Widget_SetHidden".}
proc show*(w: LCUI_Widget) {.lcui, importc: "Widget_Show".}
proc Hide*(w: LCUI_Widget) {.lcui, importc: "Widget_Hide".}
proc setPosition*(w: LCUI_Widget; position: LCUI_StyleValue) {.lcui,
    importc: "Widget_SetPosition".}
proc setOpacity*(w: LCUI_Widget; opacity: cfloat) {.lcui,
    importc: "Widget_SetOpacity".}
proc setBoxSizing*(w: LCUI_Widget; sizing: LCUI_StyleValue) {.lcui,
    importc: "Widget_SetBoxSizing".}
##  Collect all child widget that have a ref attribute specified

#proc collectReferences*(w: LCUI_Widget): ptr Dict {.lcui,
#    importc: "Widget_CollectReferences".}
##
##  Get the first widget that match the type by testing the widget itself and
##  traversing up through its ancestors.
##

proc getClosest*(w: LCUI_Widget; `type`: cstring): LCUI_Widget {.lcui,
    importc: "Widget_GetClosest".}

##  将部件与子部件列表断开链接

proc unlink*(widget: LCUI_Widget): cint {.lcui, importc: "Widget_Unlink".}
##  向子部件列表追加部件

proc append*(container: LCUI_Widget; widget: LCUI_Widget): cint {.lcui,
    importc: "Widget_Append".}
##  将部件插入到子部件列表的开头处



proc prepend*(parent: LCUI_Widget; widget: LCUI_Widget): cint {.lcui,
    importc: "Widget_Prepend".}
##  移除部件，并将其子级部件转移至父部件内

proc unwrap*(widget: LCUI_Widget): cint {.lcui, importc: "Widget_Unwrap".}
##  清空部件内的子级部件

proc empty*(widget: LCUI_Widget) {.lcui, importc: "Widget_Empty".}
##  获取上一个部件

proc getPrev*(w: LCUI_Widget): LCUI_Widget {.lcui, importc: "Widget_GetPrev".}
##  获取下一个部件

proc getNext*(w: LCUI_Widget): LCUI_Widget {.lcui, importc: "Widget_GetNext".}
##  获取一个子部件

proc getChild*(w: LCUI_Widget; index: csize_t): LCUI_Widget {.lcui,
    importc: "Widget_GetChild".}
##  Traverse the child widget tree

proc each*(w: LCUI_Widget;
                callback: proc (a1: LCUI_Widget; a2: pointer) {.cdecl.};
                    arg: pointer): csize_t {.
    lcui, importc: "Widget_Each".}
##  获取当前点命中的最上层可见部件

proc at*(widget: LCUI_Widget; x: cint; y: cint): LCUI_Widget {.lcui,
    importc: "Widget_At".}
proc destroyChildren*(w: LCUI_Widget) {.lcui,
    importc: "Widget_DestroyChildren".}
proc printTree*(w: LCUI_Widget) {.lcui, importc: "Widget_PrintTree".}

proc reflow*(w: LCUI_Widget; rule: LCUI_LayoutRule) {.lcui,
    importc: "Widget_Reflow".}
proc autoReflow*(w: LCUI_Widget; rule: LCUI_LayoutRule): Lcui_Bool {.lcui,
    importc: "Widget_AutoReflow".}

##  更新当前任务状态，确保部件的任务能够被处理到

proc updateTaskStatus*(widget: LCUI_Widget) {.lcui,
    importc: "Widget_UpdateTaskStatus".}
##  添加任务

proc addTask*(widget: LCUI_Widget; taskType: cint) {.lcui,
    importc: "Widget_AddTask".}
##  处理部件中当前积累的任务

proc update*(w: LCUI_Widget): csize_t {.lcui, importc: "Widget_Update".}
proc updateWithProfile*(w: LCUI_Widget; profile: LCUI_WidgetTasksProfile) {.
    lcui, importc: "Widget_UpdateWithProfile".}
##  为子级部件添加任务

proc addTaskForChildren*(widget: LCUI_Widget; task: cint) {.lcui,
    importc: "Widget_AddTaskForChildren".}
##  初始化 LCUI 部件任务处理功能

proc initTasks*() {.lcui, importc: "LCUIWidget_InitTasks".}
##  销毁（释放） LCUI 部件任务处理功能的相关资源

proc freeTasks*() {.lcui, importc: "LCUIWidget_FreeTasks".}
##  处理一次当前积累的部件任务

proc update*(): csize_t {.lcui, importc: "LCUIWidget_Update".}
proc updateWithProfile*(profile: LCUI_WidgetTasksProfile) {.lcui,
    importc: "LCUIWidget_UpdateWithProfile".}
##  刷新所有部件的样式

proc refreshStyle*() {.lcui, importc: "LCUIWidget_RefreshStyle".}

##  标记部件中的无效区域
##  @param[in] w		区域所在的部件
##  @param[in] r		矩形区域
##  @param[in] box_type	区域相对于何种框进行定位
##  @returns 标记成功返回 TRUE，如果该区域处于屏幕可见区域外则标记失败，返回FALSE
##

proc invalidateArea*(widget: LCUI_Widget; inRect: ptr LCUI_RectF;
    boxType: cint): Lcui_Bool {.
    lcui, importc: "Widget_InvalidateArea".}
##
##  取出部件中的无效区域
##  @param[in] w		部件
##  @param[out] rects	输出的区域列表
##  @return 无效区域的数量
##

proc getInvalidArea*(w: LCUI_Widget; rects: ptr LinkedList): csize_t {.lcui,
    importc: "Widget_GetInvalidArea".}
##
##  将部件中的矩形区域转换成指定范围框内有效的矩形区域
##  @param[in]	w		目标部件
##  @param[in]	in_rect		相对于部件呈现框的矩形区域
##  @param[out]	out_rect	转换后的区域
##  @param[in]	box_type	转换后的区域所处的范围框
##

proc convertArea*(w: LCUI_Widget; inRect: ptr LCUI_Rect; outRect: ptr LCUI_Rect;
                       boxType: cint): cint {.lcui,
                           importc: "Widget_ConvertArea".}
##  将 LCUI_RectF 类型数据转换为无效区域

proc rectFToInvalidArea*(rect: ptr LCUI_RectF; area: ptr LCUI_Rect) {.lcui,
    importc: "RectFToInvalidArea".}
##  将 LCUI_Rect 类型数据转换为无效区域

proc rectToInvalidArea*(rect: ptr LCUI_Rect; area: ptr LCUI_Rect) {.lcui,
    importc: "RectToInvalidArea".}
##
##  渲染指定部件呈现的图形内容
##  @param[in] w		部件
##  @param[in] paint 	进行绘制时所需的上下文
##  @return		返回实际渲染的部件的数量
##

proc render*(w: LCUI_Widget; paint: LCUI_PaintContext): csize_t {.lcui,
    importc: "Widget_Render".}
proc initRenderer*() {.lcui, importc: "LCUIWidget_InitRenderer".}
proc freeRenderer*() {.lcui, importc: "LCUIWidget_FreeRenderer".}

proc initPrototype*() {.lcui, importc: "LCUIWidget_InitPrototype".}
proc freePrototype*() {.lcui, importc: "LCUIWidget_FreePrototype".}
proc getPrototype*(name: cstring): LCUI_WidgetPrototype {.lcui,
    importc: "LCUIWidget_GetPrototype".}
proc newPrototype*(name: cstring; parentName: cstring): LCUI_WidgetPrototype {.
    lcui, importc: "LCUIWidget_NewPrototype".}
##  判断部件类型

proc checkType*(w: LCUI_Widget; `type`: cstring): Lcui_Bool {.lcui,
    importc: "Widget_CheckType".}
##  判断部件原型

proc checkPrototype*(w: LCUI_Widget; proto: LCUI_WidgetPrototypeC): Lcui_Bool {.
    lcui, importc: "Widget_CheckPrototype".}
proc getData*(widget: LCUI_Widget; proto: LCUI_WidgetPrototype): pointer {.
    lcui, importc: "Widget_GetData".}
proc addData*(widget: LCUI_Widget; proto: LCUI_WidgetPrototype;
                   dataSize: csize_t): pointer {.lcui,
                       importc: "Widget_AddData".}
##  清除部件自带的原型数据

proc clearPrototype*(widget: LCUI_Widget) {.lcui,
    importc: "Widget_ClearPrototype".}

type
  LCUI_WidgetEventType* = enum
    LCUI_WEVENT_NONE, LCUI_WEVENT_LINK, ## < link widget node to the parent widget children list
    LCUI_WEVENT_UNLINK,      ## < unlink widget node from the parent widget children list
    LCUI_WEVENT_READY,       ## < after widget initial layout was completed
    LCUI_WEVENT_DESTROY,     ## < before destroy
    LCUI_WEVENT_MOVE,        ## < 在移动位置时
    LCUI_WEVENT_RESIZE,      ## < 改变尺寸
    LCUI_WEVENT_SHOW,        ## < 显示
    LCUI_WEVENT_HIDE,        ## < 隐藏
    LCUI_WEVENT_FOCUS,       ## < 获得焦点
    LCUI_WEVENT_BLUR,        ## < 失去焦点
    LCUI_WEVENT_AFTERLAYOUT, ## < 在子部件布局完成后
    LCUI_WEVENT_KEYDOWN,     ## < 按键按下
    LCUI_WEVENT_KEYUP,       ## < 按键释放
    LCUI_WEVENT_KEYPRESS,    ## < 按键字符输入
    LCUI_WEVENT_TEXTINPUT,   ## < 文本输入
    LCUI_WEVENT_MOUSEOVER,   ## < 鼠标在部件上
    LCUI_WEVENT_MOUSEMOVE,   ## < 鼠标在部件上移动
    LCUI_WEVENT_MOUSEOUT,    ## < 鼠标从部件上移开
    LCUI_WEVENT_MOUSEDOWN,   ## < 鼠标按键按下
    LCUI_WEVENT_MOUSEUP,     ## < 鼠标按键释放
    LCUI_WEVENT_MOUSEWHEEL,  ## < 鼠标滚轮滚动时
    LCUI_WEVENT_CLICK,       ## < 鼠标单击
    LCUI_WEVENT_DBLCLICK,    ## < 鼠标双击
    LCUI_WEVENT_TOUCH,       ## < 触控
    LCUI_WEVENT_TOUCHDOWN,   ## < 触点按下
    LCUI_WEVENT_TOUCHUP,     ## < 触点释放
    LCUI_WEVENT_TOUCHMOVE,   ## < 触点移动
    LCUI_WEVENT_TITLE, LCUI_WEVENT_SURFACE, LCUI_WEVENT_USER


##  部件的事件数据结构和系统事件一样

type
  LCUI_WidgetMouseMotionEvent* = LCUI_MouseMotionEvent
  LCUI_WidgetMouseButtonEvent* = LCUI_MouseButtonEvent
  LCUI_WidgetMouseWheelEvent* = LCUI_MouseWheelEvent
  LCUI_WidgetTextInputEvent* = LCUI_TextInputEvent
  LCUI_WidgetKeyboardEvent* = LCUI_KeyboardEvent
  LCUI_WidgetTouchEvent* = LCUI_TouchEvent

  INNER_C_UNION_widget_event_2* {.bycopy, union.} = object
    motion*: LCUI_WidgetMouseMotionEvent
    button*: LCUI_WidgetMouseButtonEvent
    wheel*: LCUI_WidgetMouseWheelEvent
    key*: LCUI_WidgetKeyboardEvent
    touch*: LCUI_WidgetTouchEvent
    text*: LCUI_WidgetTextInputEvent

  LCUI_WidgetEventRec* {.bycopy.} = object
    `type`*: uint32
    ## < 事件类型标识号
    data*: pointer
    ## < 附加数据
    target*: LCUI_Widget
    ## < 触发事件的部件
    cancelBubble*: Lcui_Bool
    ## < 是否取消事件冒泡
    anoWidgetEvent3*: INNER_C_UNION_widget_event_2

  LCUI_WidgetEvent* = ptr LCUI_WidgetEventRec
  LCUI_WidgetEventFunc* = proc (a1: LCUI_Widget; a2: LCUI_WidgetEvent;
      a3: pointer) {.
      cdecl.}

##  设置阻止部件及其子级部件的事件

template widgetBlockEvent*(widget, flag: untyped): untyped =
  (widget).eventBlocked = flag

##  触发事件，让事件处理器在主循环中调用

proc postEvent*(widget: LCUI_Widget; ev: LCUI_WidgetEvent; data: pointer;
                     destroyData: proc (
                         a1: pointer) {.cdecl.}): Lcui_Bool {.lcui,
    importc: "Widget_PostEvent".}
##  触发事件，直接调用事件处理器

proc triggerEvent*(widget: LCUI_Widget; e: LCUI_WidgetEvent;
    data: pointer): cint {.
    lcui, importc: "Widget_TriggerEvent".}
##  自动分配一个可用的事件标识号

proc allocEventId*(): cint {.lcui, importc: "LCUIWidget_AllocEventId".}
##  设置与事件标识号对应的名称

proc setEventName*(eventId: cint; eventName: cstring): cint {.lcui,
    importc: "LCUIWidget_SetEventName".}
##  获取与事件标识号对应的名称

proc getEventName*(eventId: cint): cstring {.lcui,
    importc: "LCUIWidget_GetEventName".}
##  获取与事件名称对应的标识号

proc getEventId*(eventName: cstring): cint {.lcui,
    importc: "LCUIWidget_GetEventId".}
proc initWidgetEvent*(e: LCUI_WidgetEvent; name: cstring) {.lcui,
    importc: "LCUI_InitWidgetEvent".}
##
##  添加部件事件绑定
##  @param[in] widget 目标部件
##  @param[in] event_id 事件标识号
##  @param[in] func 事件处理函数
##  @param[in] data 事件处理函数的附加数据
##  @param[in] destroy_data 数据的销毁函数
##  @return 成功则返回事件处理器的标识号，失败则返回负数
##

proc bindEventById*(widget: LCUI_Widget; eventId: cint;
                         `func`: LCUI_WidgetEventFunc; data: pointer;
                         destroyData: proc (
                             a1: pointer) {.cdecl.}): cint {.lcui,
    importc: "Widget_BindEventById".}
##
##  添加部件事件绑定
##  @param[in] widget 目标部件
##  @param[in] event_name 事件名称
##  @param[in] func 事件处理函数
##  @param[in] data 事件处理函数的附加数据
##  @param[in] destroy_data 数据的销毁函数
##  @return 成功则返回事件处理器的标识号，失败则返回负数
##

proc bindEvent*(widget: LCUI_Widget; eventName: cstring;
                     `func`: LCUI_WidgetEventFunc; data: pointer;
                     destroyData: proc (a1: pointer) {.cdecl.}): cint {.lcui,
    importc: "Widget_BindEvent".}
##
##  解除部件事件绑定
##  @param[in] widget 目标部件
##  @param[in] event_id 事件标识号
##  @param[in] func 与事件绑定的函数
##

proc unbindEventById*(widget: LCUI_Widget; eventId: cint;
                           `func`: LCUI_WidgetEventFunc): cint {.lcui,
    importc: "Widget_UnbindEventById".}
##
##  解除部件事件绑定
##  @param[in] widget 目标部件
##  @param[in] handler_id 事件处理器标识号
##

proc unbindEventByHandlerId*(widget: LCUI_Widget; handlerId: cint): cint {.
    lcui, importc: "Widget_UnbindEventByHandlerId".}
##
##  解除部件事件绑定
##  @param[in] widget 目标部件
##  @param[in] event_name 事件名称
##  @param[in] func 与事件绑定的函数
##

proc unbindEvent*(widget: LCUI_Widget; eventName: cstring;
                       `func`: LCUI_WidgetEventFunc): cint {.lcui,
    importc: "Widget_UnbindEvent".}
##
##  投递表面（surface）事件
##
## 表面是与顶层部件绑定在一起的，只有当部件为顶层部件时，才能投递表面事件。
##
## 表面事件主要用于让表面与部件同步一些数据，如：大小、位置、显示/隐藏。
##  @param event_type 事件类型
##  @param @sync_props 是否将部件的属性同步给表面
##

proc postSurfaceEvent*(w: LCUI_Widget; eventType: cint;
    syncProps: Lcui_Bool): cint {.
    lcui, importc: "Widget_PostSurfaceEvent".}
##  清除事件对象，通常在部件销毁时调用该函数，以避免部件销毁后还有事件发送给它

proc clearEventTarget*(widget: LCUI_Widget) {.lcui,
    importc: "LCUIWidget_ClearEventTarget".}
##  get current focused widget

proc getFocus*(): LCUI_Widget {.lcui, importc: "LCUIWidget_GetFocus".}
##  将一个部件设置为焦点

proc setFocus*(widget: LCUI_Widget): cint {.lcui,
    importc: "LCUIWidget_SetFocus".}
##  停止部件的事件传播

proc stopEventPropagation*(widget: LCUI_Widget): cint {.lcui,
    importc: "Widget_StopEventPropagation".}
##  为部件设置鼠标捕获，设置后将捕获全局范围内的鼠标事件

proc setMouseCapture*(w: LCUI_Widget) {.lcui,
    importc: "Widget_SetMouseCapture".}
##  为部件解除鼠标捕获

proc releaseMouseCapture*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ReleaseMouseCapture".}
##
##  为部件设置触点捕获，设置后将捕获全局范围内的触点事件
##  @param[in] w 部件
##  @param[in] point_id 触点ID，当值为 -1 时则捕获全部触点
##  @returns 设置成功返回 0，如果其它部件已经捕获该触点则返回 -1
##

proc setTouchCapture*(w: LCUI_Widget; pointId: cint): cint {.lcui,
    importc: "Widget_SetTouchCapture".}
##
##  为部件解除触点捕获
##  @param[in] w 部件
##  @param[in] point_id 触点ID，当值为 -1 时则解除全部触点的捕获
##

proc releaseTouchCapture*(w: LCUI_Widget; pointId: cint): cint {.lcui,
    importc: "Widget_ReleaseTouchCapture".}
proc destroyEventTrigger*(w: LCUI_Widget) {.lcui,
    importc: "Widget_DestroyEventTrigger".}
##  初始化 LCUI 部件的事件系统

proc initEvent*() {.lcui, importc: "LCUIWidget_InitEvent".}
##  销毁（释放） LCUI 部件的事件系统的相关资源

proc freeEvent*() {.lcui, importc: "LCUIWidget_FreeEvent".}
proc initStyle*() {.lcui, importc: "LCUIWidget_InitStyle".}
##  销毁，释放资源

proc freeStyle*() {.lcui, importc: "LCUIWidget_FreeStyle".}
##  打印部件的样式表

proc printStyleSheets*(w: LCUI_Widget) {.lcui,
    importc: "Widget_PrintStyleSheets".}
##  Set widget style by string

proc setStyleString*(w: LCUI_Widget; name: cstring; value: cstring) {.lcui,
    importc: "Widget_SetStyleString".}
proc computePaddingStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputePaddingStyle".}
proc computeMarginStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeMarginStyle".}
proc computeProperties*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeProperties".}
proc computeWidthLimitStyle*(w: LCUI_Widget; rule: LCUI_LayoutRule) {.lcui,
    importc: "Widget_ComputeWidthLimitStyle".}
proc computeHeightLimitStyle*(w: LCUI_Widget; rule: LCUI_LayoutRule) {.lcui,
    importc: "Widget_ComputeHeightLimitStyle".}
proc computeHeightStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeHeightStyle".}
proc computeWidthStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeWidthStyle".}
proc computeSizeStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeSizeStyle".}
proc computeVisibilityStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeVisibilityStyle".}
proc computeDisplayStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeDisplayStyle".}
proc computeOpacityStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeOpacityStyle".}
proc computeZIndexStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeZIndexStyle".}
proc computePositionStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputePositionStyle".}
proc computeFlexBoxStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeFlexBoxStyle".}
proc computeFlexBasisStyle*(w: LCUI_Widget) {.lcui,
    importc: "Widget_ComputeFlexBasisStyle".}
##  更新当前部件的样式

proc updateStyle*(w: LCUI_Widget; isRefreshAll: Lcui_Bool) {.lcui,
    importc: "Widget_UpdateStyle".}
##  更新当前部件的子级部件样式

proc updateChildrenStyle*(w: LCUI_Widget; isRefreshAll: Lcui_Bool) {.lcui,
    importc: "Widget_UpdateChildrenStyle".}
proc addTaskByStyle*(w: LCUI_Widget; key: cint) {.lcui,
    importc: "Widget_AddTaskByStyle".}
##  直接更新当前部件的样式

proc execUpdateStyle*(w: LCUI_Widget; isUpdateAll: Lcui_Bool) {.lcui,
    importc: "Widget_ExecUpdateStyle".}
proc destroyStyleSheets*(w: LCUI_Widget) {.lcui,
    importc: "Widget_DestroyStyleSheets".}
##  获取选择器结点

proc getSelectorNode*(w: LCUI_Widget): LCUI_SelectorNode {.lcui,
    importc: "Widget_GetSelectorNode".}
##  获取选择器

proc getSelector*(w: LCUI_Widget): LCUI_Selector {.lcui,
    importc: "Widget_GetSelector".}
##  获取样式受到影响的子级部件数量

proc getChildrenStyleChanges*(w: LCUI_Widget; `type`: cint;
    name: cstring): csize_t {.
    lcui, importc: "Widget_GetChildrenStyleChanges".}

proc initWidget*() {.lcui, importc: "LCUI_InitWidget".}
proc freeWidget*() {.lcui, importc: "LCUI_FreeWidget".}
proc hasStatus*(w: LCUI_Widget; statusName: cstring): Lcui_Bool {.cdecl,
    importc: "Widget_HasStatus".}

proc setDisabled*(w: LCUI_Widget; disabled: Lcui_Bool) {.cdecl,
    importc: "Widget_SetDisabled".}
proc destroyStatus*(w: LCUI_Widget) {.cdecl, importc: "Widget_DestroyStatus".}
##  LCUI_END_HEADER