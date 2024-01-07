##
##  LCUI.h -- common data type definitions, macro definitions and function
##  declarations.
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

##  #define ASSIGN(NAME, TYPE) TYPE NAME = (TYPE)malloc(sizeof(TYPE##Rec))
##  #define ZEROSET(NAME, TYPE) memset(NAME, 0, sizeof(TYPE##Rec))
##  #define NEW(TYPE, COUNT) (TYPE *)calloc(COUNT, sizeof(TYPE))
##  #define CodeToString(...) "" #__VA_ARGS__ ""
##  LCUI_BEGIN_HEADER

include incl

type
  uintT* = cuint
  Lcui_Bool* = uint8
  UcharT* = uint8
  CallBackFunc* = proc (a1: pointer; a2: pointer) {.cdecl.}

##  色彩模式

type
  LCUI_ColorType* = enum
    LCUI_COLOR_TYPE_INDEX8,   ## < 8位索引
    LCUI_COLOR_TYPE_GRAY8,    ## < 8位灰度
    LCUI_COLOR_TYPE_RGB323,   ## < RGB323
    LCUI_COLOR_TYPE_ARGB2222, ## < ARGB2222
    LCUI_COLOR_TYPE_RGB555,   ## < RGB555
    LCUI_COLOR_TYPE_RGB565,   ## < RGB565
    LCUI_COLOR_TYPE_RGB888,   ## < RGB888
    LCUI_COLOR_TYPE_ARGB8888  ## < RGB8888


const
  LCUI_COLOR_TYPE_RGB* = ord Lcui_Color_Type_Rgb888
  LCUI_COLOR_TYPE_ARGB* = ord Lcui_Color_Type_Argb8888
  LCUI_MAX_FRAMES_PER_SEC* = 120
  LCUI_MAX_FRAME_MSEC* = ((int)(1000 div Lcui_Max_Frames_Per_Sec + 0.5))

type
  INNER_C_STRUCT_types_4* {.bycopy.} = object
    b* {.bitsize: 5.}: UcharT
    g* {.bitsize: 6.}: UcharT
    r* {.bitsize: 5.}: UcharT

  INNER_C_STRUCT_types_6* {.bycopy.} = object
    blue* {.bitsize: 5.}: UcharT
    green* {.bitsize: 6.}: UcharT
    red* {.bitsize: 5.}: UcharT

  INNER_C_STRUCT_types_12* {.bycopy.} = object
    b*: UcharT
    g*: UcharT
    r*: UcharT
    a*: UcharT

  INNER_C_STRUCT_types_14* {.bycopy.} = object
    blue*: UcharT
    green*: UcharT
    red*: UcharT
    alpha*: UcharT

  Lcui_Rgb565* {.bycopy, union.} = object
    value*: cushort
    anoTypes5*: INNER_C_STRUCT_types_4
    anoTypes7*: INNER_C_STRUCT_types_6

  Lcui_Argb* {.bycopy, union.} = object
    value*: int32
    anoTypes13*: INNER_C_STRUCT_types_12
    anoTypes15*: INNER_C_STRUCT_types_14

  Lcui_Argb8888* = Lcui_Argb
  LCUI_Color* = Lcui_Argb

##  Position in plane coordinate system

type
  LCUI_Pos* {.bycopy.} = object
    x*: cint
    y*: cint

  LCUI_Size* {.bycopy.} = object
    width*: cint
    height*: cint

  LCUI_Rect* {.bycopy.} = object
    x*: cint
    y*: cint
    width*: cint
    height*: cint

  LCUI_Rect2* {.bycopy.} = object
    left*: cint
    top*: cint
    right*: cint
    bottom*: cint

  LCUI_RectF* {.bycopy.} = object
    x*: cfloat
    y*: cfloat
    width*: cfloat
    height*: cfloat

  LCUI_Rect2F* {.bycopy.} = object
    left*: cfloat
    top*: cfloat
    right*: cfloat
    bottom*: cfloat


##  FIXME: remove LCUI_StyleValue
##  These values do not need to put in LCUI_StyleValue, because they are not
##  strongly related and should be defined separately where they are needed.
##

type
  LCUI_StyleValue* = enum
    SV_NONE, SV_AUTO, SV_NORMAL, SV_INHERIT, SV_INITIAL, SV_CONTAIN, SV_COVER, SV_LEFT,
    SV_CENTER, SV_RIGHT, SV_TOP, SV_TOP_LEFT, SV_TOP_CENTER, SV_TOP_RIGHT, SV_MIDDLE,
    SV_CENTER_LEFT, SV_CENTER_CENTER, SV_CENTER_RIGHT, SV_BOTTOM, SV_BOTTOM_LEFT,
    SV_BOTTOM_CENTER, SV_BOTTOM_RIGHT, SV_SOLID, SV_DOTTED, SV_DOUBLE, SV_DASHED,
    SV_CONTENT_BOX, SV_PADDING_BOX, SV_BORDER_BOX, SV_GRAPH_BOX, SV_STATIC,
    SV_RELATIVE, SV_ABSOLUTE, SV_BLOCK, SV_INLINE_BLOCK, SV_FLEX, SV_FLEX_START,
    SV_FLEX_END, SV_STRETCH, SV_SPACE_BETWEEN, SV_SPACE_AROUND, SV_SPACE_EVENLY,
    SV_WRAP, SV_NOWRAP, SV_ROW, SV_COLUMN


##  样式变量类型

type
  LCUI_StyleType* = enum
    LCUI_STYPE_NONE, LCUI_STYPE_AUTO, LCUI_STYPE_SCALE, LCUI_STYPE_PX,
    LCUI_STYPE_PT, LCUI_STYPE_DIP, LCUI_STYPE_SP, LCUI_STYPE_COLOR,
    LCUI_STYPE_IMAGE, LCUI_STYPE_STYLE, LCUI_STYPE_INT, LCUI_STYPE_BOOL,
    LCUI_STYPE_STRING, LCUI_STYPE_WSTRING

type
  INNER_C_STRUCT_types_17* {.bycopy.} = object
    style*: cint
    width*: cfloat
    color*: LCUI_Color

  INNER_C_UNION_types_20* {.bycopy, union.} = object
    source*: ptr LCUI_Graph
    sourceRo*: ptr LCUI_Graph

  LCUI_BoxShadowStyle* {.bycopy.} = object
    x*: cfloat
    y*: cfloat
    blur*: cfloat
    spread*: cfloat
    color*: LCUI_Color

  LCUI_BoxShadow* {.bycopy.} = object
    x*: cint
    y*: cint
    blur*: cint
    spread*: cint
    color*: LCUI_Color
    topLeftRadius*: cint
    topRightRadius*: cint
    bottomLeftRadius*: cint
    bottomRightRadius*: cint

  LCUI_BorderStyle* {.bycopy.} = object
    top*: INNER_C_STRUCT_types_17
    right*: INNER_C_STRUCT_types_17
    bottom*: INNER_C_STRUCT_types_17
    left*: INNER_C_STRUCT_types_17
    topLeftRadius*: cfloat
    topRightRadius*: cfloat
    bottomLeftRadius*: cfloat
    bottomRightRadius*: cfloat

  LCUI_BorderLine* {.bycopy.} = object
    style*: cint
    width*: cuint
    color*: LCUI_Color

  LCUI_Border* {.bycopy.} = object
    top*: LCUI_BorderLine
    right*: LCUI_BorderLine
    bottom*: LCUI_BorderLine
    left*: LCUI_BorderLine
    topLeftRadius*: cuint
    topRightRadius*: cuint
    bottomLeftRadius*: cuint
    bottomRightRadius*: cuint

  LCUI_GraphQuote* {.bycopy.} = object
    top*: cint
    left*: cint
    isValid*: Lcui_Bool
    isWritable*: Lcui_Bool
    anoTypes21*: INNER_C_UNION_types_20

  INNER_C_UNION_types_22* {.bycopy, union.} = object
    bytes*: ptr UcharT
    argb*: ptr Lcui_Argb

  LCUI_Graph* {.bycopy.} = object
    width*: cuint
    height*: cuint
    quote*: LCUI_GraphQuote
    anoTypes23*: INNER_C_UNION_types_22
    colorType*: LCUI_ColorType
    bytesPerPixel*: cuint
    bytesPerRow*: cuint
    opacity*: cfloat
    memSize*: csize_t
    palette*: ptr UcharT

  INNER_C_UNION_types_26* {.bycopy, union.} = object
    valInt*: cint
    val0*: cint
    valNone*: cint
    value*: cfloat
    px*: cfloat
    valPx*: cfloat
    pt*: cfloat
    valPt*: cfloat
    dp*: cfloat
    valDp*: cfloat
    dip*: cfloat
    valDip*: cfloat
    sp*: cfloat
    valSp*: cfloat
    style*: LCUI_StyleValue
    valStyle*: LCUI_StyleValue
    scale*: cfloat
    valScale*: cfloat
    string*: cstring
    valString*: cstring
    wstring*: WideCString
    valWstring*: WideCString
    color*: LCUI_Color
    valColor*: LCUI_Color
    image*: ptr LCUI_Graph
    valImage*: ptr LCUI_Graph
    valBool*: Lcui_Bool

  INNER_C_STRUCT_types_33* {.bycopy.} = object
    x*: LCUI_StyleRec
    y*: LCUI_StyleRec

  INNER_C_UNION_types_32* {.bycopy, union.} = object
    anoTypes34*: INNER_C_STRUCT_types_33
    value*: cint

  INNER_C_STRUCT_types_41* {.bycopy.} = object
    width*: LCUI_StyleRec
    height*: LCUI_StyleRec

  INNER_C_UNION_types_40* {.bycopy, union.} = object
    anoTypes42*: INNER_C_STRUCT_types_41
    value*: cint

  INNER_C_STRUCT_types_45* {.bycopy.} = object
    x*: Lcui_Bool
    y*: Lcui_Bool

  INNER_C_STRUCT_types_49* {.bycopy.} = object
    x*: Lcui_Bool
    y*: Lcui_Bool

  INNER_C_STRUCT_types_50* {.bycopy.} = object
    x*: cint
    y*: cint

  INNER_C_STRUCT_types_51* {.bycopy.} = object
    width*: cint
    height*: cint

  LCUI_StyleRec* {.bycopy.} = object
    isValid* {.bitsize: 2.}: Lcui_Bool
    `type`* {.bitsize: 6.}: LCUI_StyleType
    anoTypes27*: INNER_C_UNION_types_26

  LCUI_Style* = ptr LCUI_StyleRec
  LCUI_SizingRule* = enum
    LCUI_SIZING_RULE_NONE, LCUI_SIZING_RULE_FIXED, LCUI_SIZING_RULE_FILL,
    LCUI_SIZING_RULE_PERCENT, LCUI_SIZING_RULE_FIT_CONTENT
  LCUI_LayoutRule* = enum
    LCUI_LAYOUT_RULE_AUTO, LCUI_LAYOUT_RULE_MAX_CONTENT,
    LCUI_LAYOUT_RULE_FIXED_WIDTH, LCUI_LAYOUT_RULE_FIXED_HEIGHT,
    LCUI_LAYOUT_RULE_FIXED
  LCUI_FlexBoxLayoutStyle* {.bycopy.} = object
    ##
    ##  The flex shrink factor of a flex item
    ##  See more:
    ##  https://developer.mozilla.org/en-US/docs/Web/CSS/flex-shrink
    ##
    shrink*: cfloat
    ##  the flex grow factor of a flex item main size
    ##  See more: https://developer.mozilla.org/en-US/docs/Web/CSS/flex-grow
    ##
    grow*: cfloat
    ##
    ##  The initial main size of a flex item
    ##  See more: https://developer.mozilla.org/en-US/docs/Web/CSS/flex-basis
    ##
    basis*: cfloat
    wrap* {.bitsize: 8.}: LCUI_StyleValue
    direction* {.bitsize: 8.}: LCUI_StyleValue
    ##
    ##  Sets the align-self value on all direct children as a group
    ##  See more:
    ##  https://developer.mozilla.org/en-US/docs/Web/CSS/align-items
    ##
    alignItems* {.bitsize: 8.}: LCUI_StyleValue
    ##
    ##  Sets the distribution of space between and around content items along
    ##  a flexbox's cross-axis
    ##  See more: https://developer.mozilla.org/en-US/docs/Web/CSS/align-content
    ##
    alignContent* {.bitsize: 8.}: LCUI_StyleValue
    ##
    ##  Defines how the browser distributes space between and around content
    ##  items along the main-axis of a flex container See more:
    ##  https://developer.mozilla.org/en-US/docs/Web/CSS/justify-content
    ##
    justifyContent* {.bitsize: 8.}: LCUI_StyleValue

  LCUI_BoundBox* {.bycopy.} = object
    top*: LCUI_StyleRec
    right*: LCUI_StyleRec
    bottom*: LCUI_StyleRec
    left*: LCUI_StyleRec

  LCUI_BackgroundPosition* {.bycopy.} = object
    usingValue*: Lcui_Bool
    anoTypes35*: INNER_C_UNION_types_32

  LCUI_BackgroundSize* {.bycopy.} = object
    usingValue*: Lcui_Bool
    anoTypes43*: INNER_C_UNION_types_40

  LCUI_BackgroundStyle* {.bycopy.} = object
    image*: LCUI_Graph
    ## < 背景图
    color*: LCUI_Color
    ## < 背景色
    repeat*: INNER_C_STRUCT_types_45
    ## < 背景图是否重复
    position*: LCUI_BackgroundPosition
    ## < 定位方式
    size*: LCUI_BackgroundSize
    ## < 尺寸

  LCUI_Background* {.bycopy.} = object
    image*: ptr LCUI_Graph
    ## < 背景图
    color*: LCUI_Color
    ## < 背景色
    repeat*: INNER_C_STRUCT_types_49
    ## < 背景图是否重复
    position*: INNER_C_STRUCT_types_50
    size*: INNER_C_STRUCT_types_51




##  进行绘制时所需的上下文

type
  LCUI_PaintContextRec* {.bycopy.} = object
    rect*: LCUI_Rect
    ## < 需要绘制的区域
    canvas*: LCUI_Graph
    ## < 绘制后的位图缓存（可称为：画布）
    withAlpha*: Lcui_Bool
    ## < 绘制时是否需要处理 alpha 通道

  LCUI_PaintContext* = ptr LCUI_PaintContextRec
  FuncPtr* = proc (a1: pointer) {.cdecl.}
  LCUI_WidgetTasksProfileRec* {.bycopy.} = object
    time*: clong # clock_t
    updateCount*: csize_t
    refreshCount*: csize_t
    layoutCount*: csize_t
    userTaskCount*: csize_t
    destroyCount*: csize_t
    destroyTime*: csize_t

  LCUI_WidgetTasksProfile* = ptr LCUI_WidgetTasksProfileRec
  LCUI_FrameProfileRec* {.bycopy.} = object
    timersCount*: csize_t
    timersTime*: clong # clock_t
    eventsCount*: csize_t
    eventsTime*: clong # clock_t
    renderCount*: csize_t
    renderTime*: clong # clock_t
    presentTime*: clong # clock_t
    widgetTasks*: LCUI_WidgetTasksProfileRec

  LCUI_FrameProfile* = ptr LCUI_FrameProfileRec
  LCUI_ProfileRec* {.bycopy.} = object
    startTime*: clong # clock_t
    endTime*: clong # clock_t
    framesCount*: cuint
    frames*: array[Lcui_Max_Frames_Per_Sec, LCUI_FrameProfileRec]

  LCUI_Profile* = ptr LCUI_ProfileRec

##  LCUI_END_HEADER

proc timeInit*() {.lcui, importc: "LCUITime_Init".}
proc getTime*(): int64 {.lcui, importc: "LCUI_GetTime".}
proc getTimeDelta*(start: int64): int64 {.lcui, importc: "LCUI_GetTimeDelta".}
proc sleep*(s: cuint) {.lcui, importc: "LCUI_Sleep".}
proc mSleep*(ms: cuint) {.lcui, importc: "LCUI_MSleep".}

type
  RBTreeNode* = RBTreeNodeRec
  INNER_C_UNION_rbtree_0* {.bycopy, union.} = object
    data*: pointer
    str*: cstring

  RBTreeNodeRec* {.bycopy.} = object
    color*: uint8
    key*: cint
    anoRbtree1*: INNER_C_UNION_rbtree_0
    parent*: ptr RBTreeNode
    left*: ptr RBTreeNode
    right*: ptr RBTreeNode

  RBTree* {.bycopy.} = object
    totalNode*: cint
    compare*: proc (a1: pointer; a2: pointer): cint {.cdecl.}
    destroy*: proc (a1: pointer) {.cdecl.}
    root*: ptr RBTreeNode


template rBTreeGetTotal*(rbt: untyped): untyped =
  (rbt).totalNode

template rBTreeOnCompare*(rbt, `func`: untyped): untyped =
  (rbt).compare = `func`

template rBTreeOnDestroy*(rbt, `func`: untyped): untyped =
  (rbt).destroy = `func`

proc rbtreeInit*(rbt: ptr RBTree) {.lcui, importc: "RBTree_Init".}
proc rbtreeDestroy*(rbt: ptr RBTree) {.lcui, importc: "RBTree_Destroy".}
proc rbtreeFirst*(rbt: ptr RBTree): ptr RBTreeNode {.lcui, importc: "RBTree_First".}
proc rbtreeNext*(node: ptr RBTreeNode): ptr RBTreeNode {.lcui, importc: "RBTree_Next".}
proc rbtreeSearch*(rbt: ptr RBTree; key: cint): ptr RBTreeNode {.lcui,
    importc: "RBTree_Search".}
proc rbtreeGetData*(rbt: ptr RBTree; key: cint): pointer {.lcui,
    importc: "RBTree_GetData".}
proc rbtreeInsert*(rbt: ptr RBTree; key: cint; data: pointer): ptr RBTreeNode {.lcui,
    importc: "RBTree_Insert".}
proc rbtreeErase*(rbt: ptr RBTree; key: cint): cint {.lcui, importc: "RBTree_Erase".}
proc rbtreeEraseNode*(rbt: ptr RBTree; node: ptr RBTreeNode) {.lcui,
    importc: "RBTree_EraseNode".}
proc rbtreeCustomErase*(rbt: ptr RBTree; keydata: pointer): cint {.lcui,
    importc: "RBTree_CustomErase".}
proc rbtreeCustomSearch*(rbt: ptr RBTree; keydata: pointer): ptr RBTreeNode {.lcui,
    importc: "RBTree_CustomSearch".}
proc rbtreeCustomGetData*(rbt: ptr RBTree; keydata: pointer): pointer {.lcui,
    importc: "RBTree_CustomGetData".}
proc rbtreeCustomInsert*(rbt: ptr RBTree; keydata: pointer; data: pointer): ptr RBTreeNode {.
    lcui, importc: "RBTree_CustomInsert".}

type
  LinkedListNode* = LinkedListNodeRec
  LinkedList* = LinkedListRec
  LinkedListNodeRec* {.bycopy.} = object
    data*: pointer
    prev*: ptr LinkedListNode
    next*: ptr LinkedListNode

  LinkedListRec* {.bycopy.} = object
    length*: csize_t
    head*: LinkedListNode
    tail*: LinkedListNode

##  #define LinkedList_Each(node, list) node = (list)->head.next; node; node = node->next
##
##  #define LinkedList_EachReverse(node, list) node = (list)->tail.prev; node && node != &(list)->head; node = node->prev
##
##  #define LinkedList_ForEach(node, list) for( LinkedList_Each(node, list) )
##  #define LinkedList_ForEachReverse(node, list) for( LinkedList_EachReverse(node, list) )

proc linkedListAppend*(list: ptr LinkedList; data: pointer): ptr LinkedListNode {.lcui,
    importc: "LinkedList_Append".}
proc linkedListInsert*(list: ptr LinkedList; pos: csize_t; data: pointer): ptr LinkedListNode {.
    lcui, importc: "LinkedList_Insert".}
proc linkedListGetNode*(list: ptr LinkedList; pos: csize_t): ptr LinkedListNode {.lcui,
    importc: "LinkedList_GetNode".}
proc linkedListGetNodeAtTail*(list: ptr LinkedList; pos: csize_t): ptr LinkedListNode {.
    lcui, importc: "LinkedList_GetNodeAtTail".}
proc linkedListInit*(list: ptr LinkedList) {.lcui, importc: "LinkedList_Init".}
proc linkedListGet*(list: ptr LinkedList; pos: csize_t): pointer {.lcui,
    importc: "LinkedList_Get".}
proc linkedListUnlink*(list: ptr LinkedList; node: ptr LinkedListNode) {.lcui,
    importc: "LinkedList_Unlink".}
proc linkedListLink*(list: ptr LinkedList; cur: ptr LinkedListNode;
                    node: ptr LinkedListNode) {.lcui, importc: "LinkedList_Link".}
proc linkedListDelete*(list: ptr LinkedList; pos: csize_t) {.lcui,
    importc: "LinkedList_Delete".}
proc linkedListDeleteNode*(list: ptr LinkedList; node: ptr LinkedListNode) {.lcui,
    importc: "LinkedList_DeleteNode".}
proc linkedListAppendNode*(list: ptr LinkedList; node: ptr LinkedListNode) {.lcui,
    importc: "LinkedList_AppendNode".}
proc linkedListInsertNode*(list: ptr LinkedList; pos: csize_t;
                          node: ptr LinkedListNode) {.lcui,
    importc: "LinkedList_InsertNode".}
proc linkedListClearEx*(list: ptr LinkedList;
                       onDestroy: proc (a1: pointer) {.cdecl.}; freeNode: cint) {.
    lcui, importc: "LinkedList_ClearEx".}
proc linkedListConcat*(list1: ptr LinkedList; list2: ptr LinkedList) {.lcui,
    importc: "LinkedList_Concat".}
proc linkedListNodeDelete*(node: ptr LinkedListNode) {.lcui,
    importc: "LinkedListNode_Delete".}
template linkedListClear*(list, `func`: untyped): untyped =
  linkedListClearEx(list, `func`, 1)

template linkedListClearData*(list, `func`: untyped): untyped =
  linkedListClearEx(list, `func`, 0)


type
  INNER_C_UNION_dict_1* {.bycopy, union.} = object
    val*: pointer
    u64*: uint64
    s64*: int64

  DictEntry* {.bycopy.} = object
    key*: pointer
    v*: INNER_C_UNION_dict_1
    next*: ptr DictEntry
    ## < 指向下一个哈希节点(形成链表)


##  字典内数据的类型

type
  DictType* {.bycopy.} = object
    hashFunction*: proc (key: pointer): cuint {.cdecl.}
    keyDup*: proc (privdata: pointer; key: pointer): pointer {.cdecl.}
    valDup*: proc (privdata: pointer; obj: pointer): pointer {.cdecl.}
    keyCompare*: proc (privdata: pointer; key1: pointer; key2: pointer): cint {.cdecl.}
    keyDestructor*: proc (privdata: pointer; key: pointer) {.cdecl.}
    valDestructor*: proc (privdata: pointer; obj: pointer) {.cdecl.}


##  哈希表结构

type
  DictHashTable* {.bycopy.} = object
    table*: ptr ptr DictEntry
    ## < 节点指针数组
    size*: culong
    ## < 桶的数量
    sizemask*: culong
    ## < mask 码，用于地址索引计算
    used*: culong
    ## < 已有节点数量


##  字典结构

type
  Dict* {.bycopy.} = object
    `type`*: ptr DictType
    ## < 为哈希表中不同类型的值所使用的一族函数
    privdata*: pointer
    ht*: array[2, DictHashTable]
    ## < 每个字典使用两个哈希表
    rehashidx*: cint
    ## < rehash 进行到的索引位置，如果没有在 rehash ，就为 -1
    iterators*: cint
    ## < 当前正在使用的 iterator 的数量


##  用于遍历字典的迭代器

type
  DictIterator* {.bycopy.} = object
    d*: ptr Dict
    ## < 迭代器所指向的字典
    table*: cint
    ## < 使用的哈希表号码
    index*: cint
    ## < 迭代进行的索引
    safe*: cint
    ## < 是否安全
    entry*: ptr DictEntry
    ## < 指向哈希表的当前节点
    nextEntry*: ptr DictEntry
    ## < 指向哈希表的下个节点


const
  DICT_HT_INITIAL_SIZE* = 4

template dictFreeVal*(d, entry: untyped): void =
  if (d).`type`.valDestructor:
    (d).`type`.valDestructor((d).privdata, (entry).v.val)

template dictSetVal*(d, entry, val: untyped): void =
  while true:
    if (d).`type`.valDup:
      entry.v.val = (d).`type`.valDup((d).privdata, val)
    else:
      entry.v.val = (val)
    if not 0:
      break

template dictSetSignedIntegerVal*(entry, val: untyped): void =
  while true:
    entry.v.s64 = val
    if not 0:
      break

template dictSetUnsignedIntegerVal*(entry, val: untyped): void =
  while true:
    entry.v.u64 = val
    if not 0:
      break

template dictFreeKey*(d, entry: untyped): void =
  if (d).`type`.keyDestructor:
    (d).`type`.keyDestructor((d).privdata, (entry).key)

template dictSetKey*(d, entry, key: untyped): void =
  while true:
    if (d).`type`.keyDup:
      entry.key = (d).`type`.keyDup((d).privdata, key)
    else:
      entry.key = (key)
    if not 0:
      break

template dictCompareKeys*(d, key1, key2: untyped): untyped =
  (if ((d).`type`.keyCompare): (d).`type`.keyCompare((d).privdata, key1, key2) else: (
      key1) == (key2))

template dictHashKey*(d, key: untyped): untyped =
  (d).`type`.hashFunction(key)

template dictEntryGetKey*(he: untyped): untyped =
  ((he).key)

template dictEntryGetVal*(he: untyped): untyped =
  ((he).v.val)

template dictEntryGetSignedIntegerVal*(he: untyped): untyped =
  ((he).v.s64)

template dictEntryGetUnsignedIntegerVal*(he: untyped): untyped =
  ((he).v.u64)

template dictSlots*(d: untyped): untyped =
  ((d).ht[0].size + (d).ht[1].size)

template dictSize*(d: untyped): untyped =
  ((d).ht[0].used + (d).ht[1].used)

template dictIsRehashing*(ht: untyped): untyped =
  ((ht).rehashidx != -1)

##  创建一个新字典

proc dictCreate*(`type`: ptr DictType; privdata: pointer): ptr Dict {.lcui,
    importc: "Dict_Create".}
##  对字典进行扩展

proc dictExpand*(d: ptr Dict; size: culong): cint {.lcui, importc: "Dict_Expand".}
##
##  将元素添加到目标哈希表中
##  @param[in] d 字典指针
##  @param[in] key 新元素的关键字
##  @param[in] val 新元素的值
##  @returns 添加成功为 0，添加出错为 -1
##

proc dictAdd*(d: ptr Dict; key: pointer; val: pointer): cint {.lcui, importc: "Dict_Add".}
##
##  将元素添加到目标哈希表中
##  功能与 Dict_Add() 相同，但必须指定 valDup 才能添加成功
##

proc dictAddCopy*(d: ptr Dict; key: pointer; val: pointer): cint {.lcui,
    importc: "Dict_AddCopy".}
##  添加元素的底层实现函数(由 Dict_Add 调用)

proc dictAddRaw*(d: ptr Dict; key: pointer): ptr DictEntry {.lcui,
    importc: "Dict_AddRaw".}
##
##  将新元素添加到字典，如果 key 已经存在，那么新元素覆盖旧元素。
##  @param[in] key 新元素的关键字
##  @param[in] val 新元素的值
##  @return 1 key 不存在，新建元素添加成功
##  @return 0 key 已经存在，旧元素被新元素覆盖
##

proc dictReplace*(d: ptr Dict; key: pointer; val: pointer): cint {.lcui,
    importc: "Dict_Replace".}
proc dictReplaceRaw*(d: ptr Dict; key: pointer): ptr DictEntry {.lcui,
    importc: "Dict_ReplaceRaw".}
proc dictDelete*(d: ptr Dict; key: pointer): cint {.lcui, importc: "Dict_Delete".}
proc dictDeleteNoFree*(d: ptr Dict; key: pointer): cint {.lcui,
    importc: "Dict_DeleteNoFree".}
##  删除字典，释放内存资源

proc dictRelease*(d: ptr Dict) {.lcui, importc: "Dict_Release".}
##
##  在字典中按指定的 key 查找
##  查找过程是典型的 separate chaining find 操作
##  具体参见：http://en.wikipedia.org/wiki/Hash_table#Separate_chaining
##

proc dictFind*(d: ptr Dict; key: pointer): ptr DictEntry {.lcui, importc: "Dict_Find".}
##  查找给定 key 在字典 d 中的值

proc dictFetchValue*(d: ptr Dict; key: pointer): pointer {.lcui,
    importc: "Dict_FetchValue".}
##  重新调整字典的大小，缩减多余空间

proc dictResize*(d: ptr Dict): cint {.lcui, importc: "Dict_Resize".}
##
##  创建一个迭代器，用于遍历哈希表节点。
##
##  safe
## 属性指示迭代器是否安全，如果迭代器是安全的，那么它可以在遍历的过程中
##
## 进行增删操作，反之，如果迭代器是不安全的，那么它只能执行 Dict_Next 操作。
##
##
## 因为迭代进行的时候可以对列表的当前节点进行修改，为了避免修改造成指针丢失，
##  所以不仅要有指向当前节点的 entry 属性，还需要指向下一节点的 next_entry 属性
##

proc dictGetIterator*(d: ptr Dict): ptr DictIterator {.lcui,
    importc: "Dict_GetIterator".}
##  创建一个安全迭代器

proc dictGetSafeIterator*(d: ptr Dict): ptr DictIterator {.lcui,
    importc: "Dict_GetSafeIterator".}
##  迭代器的推进函数

proc dictNext*(iter: ptr DictIterator): ptr DictEntry {.lcui, importc: "Dict_Next".}
##  删除迭代器

proc dictReleaseIterator*(iter: ptr DictIterator) {.lcui,
    importc: "Dict_ReleaseIterator".}
##  从字典中随机获取一项

proc dictGetRandomKey*(d: ptr Dict): ptr DictEntry {.lcui,
    importc: "Dict_GetRandomKey".}
##  打印字典的统计信息

proc dictPrintStats*(d: ptr Dict) {.lcui, importc: "Dict_PrintStats".}
proc dictGenHashFunction*(buf: ptr uint8; len: cint): cuint {.lcui,
    importc: "Dict_GenHashFunction".}
proc dictGenCaseHashFunction*(buf: ptr uint8; len: cint): cuint {.lcui,
    importc: "Dict_GenCaseHashFunction".}
proc dictIntHashFunction*(key: cuint): cuint {.lcui, importc: "Dict_IntHashFunction".}
##  Identity hash function for integer keys

proc dictIdentityHashFunction*(key: cuint): cuint {.lcui,
    importc: "Dict_IdentityHashFunction".}
##  清空字典

proc dictEmpty*(d: ptr Dict) {.lcui, importc: "Dict_Empty".}
proc dictEnableResize*() {.lcui, importc: "Dict_EnableResize".}
proc dictDisableResize*() {.lcui, importc: "Dict_DisableResize".}
##
##  字典的 rehash 函数
##  @param[in] n 要执行 rehash 的元素数量
##  @return 0 所有元素 rehash 完毕
##  @return 1 还有元素没有 rehash
##

proc dictRehash*(d: ptr Dict; n: cint): cint {.lcui, importc: "Dict_Rehash".}
##
##  在指定的时间内完成 rehash 操作
##  @param[in] ms 进行 rehash 的时间，以毫秒为单位
##  @returns rehashes 完成 rehash 的元素的数量
##

proc dictRehashMilliseconds*(d: ptr Dict; ms: cint): cint {.lcui,
    importc: "Dict_RehashMilliseconds".}
proc dictSetHashFunctionSeed*(initval: cuint) {.lcui,
    importc: "Dict_SetHashFunctionSeed".}
proc dictGetHashFunctionSeed*(): cuint {.lcui, importc: "Dict_GetHashFunctionSeed".}
proc stringKeyDictKeyHash*(key: pointer): cuint {.lcui,
    importc: "StringKeyDict_KeyHash".}
proc stringKeyDictKeyCompare*(privdata: pointer; key1: pointer; key2: pointer): cint {.
    lcui, importc: "StringKeyDict_KeyCompare".}
proc stringKeyDictKeyDup*(privdata: pointer; key: pointer): pointer {.lcui,
    importc: "StringKeyDict_KeyDup".}
proc stringKeyDictKeyDestructor*(privdata: pointer; key: pointer) {.lcui,
    importc: "StringKeyDict_KeyDestructor".}
proc dictInitStringKeyType*(t: ptr DictType) {.lcui,
    importc: "Dict_InitStringKeyType".}
proc dictInitStringCopyKeyType*(t: ptr DictType) {.lcui,
    importc: "Dict_InitStringCopyKeyType".}

type
  LCUI_ObjectType* = ptr LCUI_ObjectTypeRec
  LCUI_Object* = ptr LCUI_ObjectRec
  LCUI_ObjectWatcher* = ptr LCUI_ObjectWatcherRec
  LCUI_ObjectWatcherFunc* = proc (a1: LCUI_Object; a2: pointer) {.cdecl.}
  LCUI_ObjectWatcherRec = object
    data*: pointer
    `func`*: LCUI_ObjectWatcherFunc
    target*: LCUI_Object
    node*: LinkedListNode
  
  LCUI_ObjectTypeRec* {.bycopy.} = object
    hash*: cuint
    init*: proc (a1: LCUI_Object) {.cdecl.}
    destroy*: proc (a1: LCUI_Object) {.cdecl.}
    compare*: proc (a1: LCUI_Object; a2: LCUI_Object): cint {.cdecl.}
    opreate*: proc (a1: LCUI_Object; a2: cstring; a3: ptr LCUI_ObjectRec): LCUI_Object {.
        cdecl.}
    duplicate*: proc (a1: LCUI_Object; a2: ptr LCUI_ObjectRec) {.cdecl.}
    tostring*: proc (a1: LCUI_Object; a2: LCUI_Object) {.cdecl.}

  LCUI_ObjectValueUnion_object_1* {.bycopy, union.} = object
    number*: cdouble
    string*: cstring
    wstring*: WideCString
    data*: pointer

  LCUI_ObjectRec* {.bycopy.} = object
    `type`*: ptr LCUI_ObjectTypeRec
    value*: LCUI_ObjectValueUnion_object_1
    size*: csize_t
    watchers*: ptr LinkedList


proc objectTypeNew*(name: cstring): LCUI_ObjectType {.lcui,
    importc: "ObjectType_New".}
proc objectTypeDelete*(`type`: LCUI_ObjectType) {.lcui,
    importc: "ObjectType_Delete".}
proc objectInit*(`object`: LCUI_Object; `type`: ptr LCUI_ObjectTypeRec) {.lcui,
    importc: "Object_Init".}
proc objectDestroy*(`object`: LCUI_Object) {.lcui, importc: "Object_Destroy".}
proc objectNew*(`type`: ptr LCUI_ObjectTypeRec): LCUI_Object {.lcui,
    importc: "Object_New".}
proc objectDelete*(`object`: LCUI_Object) {.lcui, importc: "Object_Delete".}
proc objectDuplicate*(src: LCUI_Object): LCUI_Object {.lcui,
    importc: "Object_Duplicate".}
proc objectCompare*(a: LCUI_Object; b: LCUI_Object): cint {.lcui,
    importc: "Object_Compare".}
proc objectOperate*(self: LCUI_Object; operatorStr: cstring; another: LCUI_Object): LCUI_Object {.
    lcui, importc: "Object_Operate".}
proc objectToString*(`object`: LCUI_Object): LCUI_Object {.lcui,
    importc: "Object_ToString".}
proc objectWatch*(`object`: LCUI_Object; `func`: LCUI_ObjectWatcherFunc;
                 data: pointer): LCUI_ObjectWatcher {.lcui, importc: "Object_Watch".}
proc objectNotify*(`object`: LCUI_Object): csize_t {.lcui, importc: "Object_Notify".}
proc objectWatcherDelete*(watcher: LCUI_ObjectWatcher) {.lcui,
    importc: "ObjectWatcher_Delete".}
proc wStringSetValue*(str: LCUI_Object; value: WideCString) {.lcui,
    importc: "WString_SetValue".}
proc wStringInit*(`object`: LCUI_Object; value: WideCString) {.lcui,
    importc: "WString_Init".}
proc wStringNew*(value: WideCString): LCUI_Object {.lcui, importc: "WString_New".}
proc stringSetValue*(str: LCUI_Object; value: cstring) {.lcui,
    importc: "String_SetValue".}
proc stringInit*(`object`: LCUI_Object; value: cstring) {.lcui,
    importc: "String_Init".}
proc stringNew*(value: cstring): LCUI_Object {.lcui, importc: "String_New".}
proc numberInit*(`object`: LCUI_Object; value: cdouble) {.lcui,
    importc: "Number_Init".}
proc numberSetValue*(`object`: LCUI_Object; value: cdouble) {.lcui,
    importc: "Number_SetValue".}
proc numberNew*(value: cdouble): LCUI_Object {.lcui, importc: "Number_New".}

template lCUIRectIsIncludeRect*(a, b: untyped): untyped =
  ((b).x >= (a).x and (b).x + (b).width <= (a).x + (a).width and (b).y >= (a).y and
      (b).y + (b).height <= (a).y + (a).height)

##  LCUI_BEGIN_HEADER
##  将数值转换成LCUI_Rect型结构体

proc rect*(x: cint; y: cint; w: cint; h: cint): LCUI_Rect {.lcui, importc: "Rect".}
##  根据容器尺寸，获取指定区域中需要裁剪的区域

proc rectGetCutArea*(boxW: cint; boxH: cint; rect: LCUI_Rect; cut: ptr LCUI_Rect) {.
    lcui, importc: "LCUIRect_GetCutArea".}
template lCUIRectHasPoint*(rect, x, y: untyped): untyped =
  (x >= (rect).x and y >= (rect).y and x < (rect).x + (rect).width and
      y < (rect).y + (rect).height)

##  将矩形区域范围调整在容器有效范围内

proc rectValidateArea*(rect: ptr LCUI_Rect; boxW: cint; boxH: cint): Lcui_Bool {.
    lcui, importc: "LCUIRect_ValidateArea".}
proc rectF_ValidateArea*(rect: ptr LCUI_RectF; boxW: cfloat; boxH: cfloat): Lcui_Bool {.
    lcui, importc: "LCUIRectF_ValidateArea".}
proc rectToRectF*(rect: ptr LCUI_Rect; rectf: ptr LCUI_RectF; scale: cfloat) {.lcui,
    importc: "LCUIRect_ToRectF".}
proc rectScale*(src: ptr LCUI_Rect; dst: ptr LCUI_Rect; scale: cfloat) {.lcui,
    importc: "LCUIRect_Scale".}
proc rectF_ToRect*(rectf: ptr LCUI_RectF; rect: ptr LCUI_Rect; scale: cfloat) {.
    lcui, importc: "LCUIRectF_ToRect".}
##  检测矩形是否遮盖另一个矩形

proc rectIsCoverRect*(a: ptr LCUI_Rect; b: ptr LCUI_Rect): Lcui_Bool {.lcui,
    importc: "LCUIRect_IsCoverRect".}
proc rectF_IsCoverRect*(a: ptr LCUI_RectF; b: ptr LCUI_RectF): Lcui_Bool {.lcui,
    importc: "LCUIRectF_IsCoverRect".}
##
##  获取两个矩形中的重叠矩形
##  @param[in] a		矩形A
##  @param[in] b		矩形B
##  @param[out] out	矩形A和B重叠处的矩形
##  @returns 如果两个矩形重叠，则返回TRUE，否则返回FALSE
##

proc rectGetOverlayRect*(a: ptr LCUI_Rect; b: ptr LCUI_Rect; `out`: ptr LCUI_Rect): Lcui_Bool {.
    lcui, importc: "LCUIRect_GetOverlayRect".}
proc rectF_GetOverlayRect*(a: ptr LCUI_RectF; b: ptr LCUI_RectF;
                              `out`: ptr LCUI_RectF): Lcui_Bool {.lcui,
    importc: "LCUIRectF_GetOverlayRect".}
##  合并两个矩形

proc rectMergeRect*(big: ptr LCUI_Rect; a: ptr LCUI_Rect; b: ptr LCUI_Rect) {.lcui,
    importc: "LCUIRect_MergeRect".}
proc rectF_MergeRect*(big: ptr LCUI_RectF; a: ptr LCUI_RectF; b: ptr LCUI_RectF) {.
    lcui, importc: "LCUIRectF_MergeRect".}
##
##  根据重叠矩形 rect1，将矩形 rect2 分割成四个矩形
##  分割方法如下：
##  ┏━━┳━━━━━━┓
##  ┃    ┃     3      ┃
##  ┃ 0  ┣━━━┳━━┃
##  ┃    ┃rect1 ┃    ┃
##  ┃    ┃      ┃ 2  ┃
##  ┣━━┻━━━┫    ┃
##  ┃     1      ┃    ┃
##  ┗━━━━━━┻━━┛
##
##  rect2 必须被 rect1 完全包含
##

proc rectCutFourRect*(rect1: ptr LCUI_Rect; rect2: ptr LCUI_Rect;
                         rects: array[4, LCUI_Rect]) {.lcui,
    importc: "LCUIRect_CutFourRect".}
proc rectSplit*(base: ptr LCUI_Rect; target: ptr LCUI_Rect;
                   rects: array[4, LCUI_Rect]) {.lcui, importc: "LCUIRect_Split".}
proc rectF_IsEquals*(a: ptr LCUI_RectF; b: ptr LCUI_RectF): Lcui_Bool {.lcui,
    importc: "LCUIRectF_IsEquals".}
proc rectIsEquals*(a: ptr LCUI_Rect; b: ptr LCUI_Rect): Lcui_Bool {.lcui,
    importc: "LCUIRect_IsEquals".}
proc rectListAddEx*(list: ptr LinkedList; rect: ptr LCUI_Rect; autoMerge: Lcui_Bool): cint {.
    lcui, importc: "RectList_AddEx".}
##  添加一个脏矩形记录

proc rectListAdd*(list: ptr LinkedList; rect: ptr LCUI_Rect): cint {.lcui,
    importc: "RectList_Add".}
##  删除脏矩形

proc rectListDelete*(list: ptr LinkedList; rect: ptr LCUI_Rect): cint {.lcui,
    importc: "RectList_Delete".}
template rectListClear*(list: untyped): untyped =
  linkedListClear(list, free)

type
  StepTimer* = pointer

##  #endif
##  新建帧数控制实例

proc stepTimerCreate*(): StepTimer {.lcui, importc: "StepTimer_Create".}
##  销毁帧数控制相关资源

proc stepTimerDestroy*(timer: StepTimer) {.lcui, importc: "StepTimer_Destroy".}
##  设置最大FPS（帧数/秒）

proc stepTimerSetFrameLimit*(timer: StepTimer; max: cuint) {.lcui,
    importc: "StepTimer_SetFrameLimit".}
##  获取当前FPS

proc stepTimerGetFrameCount*(timer: StepTimer): cint {.lcui,
    importc: "StepTimer_GetFrameCount".}
##  让当前帧停留一定时间

proc stepTimerRemain*(timer: StepTimer) {.lcui, importc: "StepTimer_Remain".}
##  暂停数据帧的更新

proc stepTimerPause*(timer: StepTimer; needPause: Lcui_Bool) {.lcui,
    importc: "StepTimer_Pause".}

type
  StrlistT* = cstringArray

proc sortedstrlistAdd*(strlist: ptr StrlistT; str: cstring): cint {.lcui,
    importc: "sortedstrlist_add".}
proc strlistAddOne*(strlist: ptr StrlistT; str: cstring): cint {.lcui,
    importc: "strlist_add_one".}
proc strlistRemoveOne*(strlist: ptr StrlistT; str: cstring): cint {.lcui,
    importc: "strlist_remove_one".}
##
##  向字符串组添加字符串
##  @param[in][out] strlist 字符串组
##  @param[in] str 字符串
##

proc strlistAdd*(strlist: ptr StrlistT; str: cstring): cint {.lcui,
    importc: "strlist_add".}
##
##  判断字符串组中是否包含指定字符串
##  @param[in][out] strlist 字符串组
##  @param[in] str 字符串
##  @returns 如果包含则返回 1， 否则返回 0
##

proc strlistHas*(strlist: StrlistT; str: cstring): cint {.lcui, importc: "strlist_has".}
##
##  从字符串组中移除指定字符串
##  @param[in][out] strlist 字符串组
##  @param[in] str 字符串
##  @returns 如果删除成功则返回 1， 否则返回 0
##

proc strlistRemove*(strlist: ptr StrlistT; str: cstring): cint {.lcui,
    importc: "strlist_remove".}
##
##  向已排序的字符串组添加字符串
##  @param[in][out] strlist 字符串组
##  @param[in] str 字符串
##

proc strlistFree*(strs: StrlistT) {.lcui, importc: "strlist_free".}

proc parseNumber*(`var`: LCUI_Style; str: cstring): Lcui_Bool {.lcui,
    importc: "ParseNumber".}
proc parseRGB*(`var`: LCUI_Style; str: cstring): Lcui_Bool {.lcui, importc: "ParseRGB".}
proc parseRGBA*(`var`: LCUI_Style; str: cstring): Lcui_Bool {.lcui,
    importc: "ParseRGBA".}
##  从字符串中解析出色彩值，支持格式：#fff、#ffffff, rgba(R,G,B,A)、rgb(R,G,B)

proc parseColor*(`var`: LCUI_Style; str: cstring): Lcui_Bool {.lcui,
    importc: "ParseColor".}
##  解析资源路径

proc parseUrl*(s: LCUI_Style; str: cstring; dirname: cstring): Lcui_Bool {.lcui,
    importc: "ParseUrl".}
proc parseFontWeight*(str: cstring; weight: ptr cint): Lcui_Bool {.lcui,
    importc: "ParseFontWeight".}
proc parseFontStyle*(str: cstring; style: ptr cint): Lcui_Bool {.lcui,
    importc: "ParseFontStyle".}

type
  LCUI_EventRec* {.bycopy.} = object
    `type`*: cint
    ## < 事件类型
    data*: pointer
    ## < 事件附加数据

  LCUI_Event* = ptr LCUI_EventRec
  LCUI_EventFunc* = proc (a1: LCUI_Event; a2: pointer) {.cdecl.}
  LCUI_EventTriggerRec* {.bycopy.} = object
    handlerBaseId*: cint
    ## < 事件处理器ID
    events*: RBTree
    ## < 事件绑定记录
    handlers*: RBTree
    ## < 事件处理器记录

  LCUI_EventTrigger* = ptr LCUI_EventTriggerRec

##  构建一个事件触发器

proc eventTrigger*(): LCUI_EventTrigger {.lcui, importc: "EventTrigger".}
##  销毁一个事件触发器

proc eventTriggerDestroy*(trigger: LCUI_EventTrigger) {.lcui,
    importc: "EventTrigger_Destroy".}
##
##  绑定一个事件处理器
##  @param[in] event_id     事件标识号
##  @param[in] func         事件处理函数
##  @param[in] data         事件处理函数的附加参数
##  @param[in] destroy_data 参数的销毁函数
##  @returns 返回处理器ID
##

proc eventTriggerBind*(trigger: LCUI_EventTrigger; eventId: cint;
                      `func`: LCUI_EventFunc; data: pointer;
                      destroyData: proc (a1: pointer) {.cdecl.}): cint {.lcui,
    importc: "EventTrigger_Bind".}
##
##  解除绑定事件处理器
##  @param[in] trigger  事件触发器
##  @param[in] event_id 事件标识号
##  @param[in] func     事件处理函数
##  @returns 解绑成功返回 0，失败则返回 -1
##

proc eventTriggerUnbind*(trigger: LCUI_EventTrigger; eventId: cint;
                        `func`: LCUI_EventFunc): cint {.lcui,
    importc: "EventTrigger_Unbind".}
##
##  根据事件处理器的标识号来解除事件绑定
##  @param[in] trigger    事件触发器
##  @param[in] handler_id 事件处理器的标识号
##  @returns 解绑成功返回 0，失败则返回 -1
##

proc eventTriggerUnbind2*(trigger: LCUI_EventTrigger; handlerId: cint): cint {.lcui,
    importc: "EventTrigger_Unbind2".}
##
##  根据自定义的判断方法来解除事件绑定
##  @param[in] trigger       事件触发器
##  @param[in] event_id      事件标识号
##  @param[in] compare_func  比较函数，一致返回 1，不一致则返回 0
##  @param[in] key           用于比较的关键数据
##  @returns 解绑成功返回 0，失败则返回 -1
##

proc eventTriggerUnbind3*(trigger: LCUI_EventTrigger; eventId: cint; compareFunc: proc (
    a1: pointer; a2: pointer): cint {.cdecl.}; key: pointer): cint {.lcui,
    importc: "EventTrigger_Unbind3".}
##
##  触发事件
##  @param[in] trigger    事件触发器
##  @param[in] event_id   事件标识号
##  @param[in] arg        与事件相关的数据
##  @returns 返回已调用的事件处理器的数量
##

proc eventTriggerTrigger*(trigger: LCUI_EventTrigger; eventId: cint; arg: pointer): cint {.
    lcui, importc: "EventTrigger_Trigger".}
##  LCUI_END_HEADER

type
  LCUI_TaskFunc* = proc (a1: pointer; a2: pointer) {.cdecl.}
  LCUI_TaskRec* {.bycopy.} = object
    `func`*: LCUI_TaskFunc
    ## < 任务处理函数
    arg*: array[2, pointer]
    ## < 两个参数
    ## void(*destroy_arg[2])(void*);	/**< 参数的销毁函数 */

  LCUI_Task* = ptr LCUI_TaskRec

proc taskDestroy*(task: LCUI_Task) {.lcui, importc: "LCUITask_Destroy".}
proc taskRun*(task: LCUI_Task): cint {.lcui, importc: "LCUITask_Run".}

proc openUri*(uri: cstring): cint {.lcui, importc: "OpenUri".}

type
  EncodingType* = enum
    ENCODING_ANSI, ENCODING_UTF8


template lCUI_DecodeUTF8String*(wstr, str, max_Len: untyped): untyped =
  lCUI_DecodeString(wstr, str, max_Len, encoding_Utf8)

template lCUI_EncodeUTF8String*(str, wstr, max_Len: untyped): untyped =
  lCUI_EncodeString(str, wstr, max_Len, encoding_Utf8)

proc decodeString*(wstr: WideCString; str: cstring; maxLen: csize_t; encoding: cint): csize_t {.
    lcui, importc: "LCUI_DecodeString".}
proc encodeString*(str: cstring; wstr: WideCString; maxLen: csize_t; encoding: cint): csize_t {.
    lcui, importc: "LCUI_EncodeString".}

type
#  LCUI_AppTaskFunc* = LCUI_TaskFunc
  LCUI_SysEventType* = enum
    LCUI_NONE, LCUI_KEYDOWN,   ## < 键盘触发的按键按下事件
    LCUI_KEYPRESS,            ## <
                  ## 按键输入事件，仅字母、数字等ANSI字符键可触发
    LCUI_KEYUP,               ## < 键盘触发的按键释放事件
    LCUI_MOUSE,               ## < 鼠标事件
    LCUI_MOUSEMOVE,           ## < 鼠标触发的鼠标移动事件
    LCUI_MOUSEDOWN,           ## < 鼠标触发的按钮按下事件
    LCUI_MOUSEUP,             ## < 鼠标触发的按钮释放事件
    LCUI_MOUSEWHEEL,          ## < 鼠标触发的滚轮滚动事件
    LCUI_TEXTINPUT,           ## < 输入法触发的文本输入事件
    LCUI_TOUCH, LCUI_TOUCHMOVE, LCUI_TOUCHDOWN, LCUI_TOUCHUP, LCUI_PAINT,
    LCUI_WIDGET, LCUI_QUIT,    ## < 在 LCUI 退出前触发的事件
    LCUI_SETTINGS_CHANGE, LCUI_USER = 100 ## <
                                      ## 用户事件，可以把这个当成系统事件与用户事件的分界

type
  LCUI_TouchPointRec* {.bycopy.} = object
    x*: cint
    y*: cint
    id*: cint
    state*: cint
    isPrimary*: uint8

  LCUI_TouchPoint* = ptr LCUI_TouchPointRec
  LCUI_PaintEvent* {.bycopy.} = object
    rect*: LCUI_Rect


##  The event structure to describe a user interaction with the keyboard

type
  INNER_C_UNION_main_2* {.bycopy, union.} = object
    motion*: LCUI_MouseMotionEvent
    button*: LCUI_MouseButtonEvent
    wheel*: LCUI_MouseWheelEvent
    text*: LCUI_TextInputEvent
    key*: LCUI_KeyboardEvent
    touch*: LCUI_TouchEvent
    paint*: LCUI_PaintEvent

  LCUI_KeyboardEvent* {.bycopy.} = object
    ##  The virtual-key code of the nonsystem key
    code*: cint
    ##  whether the Ctrl key was active when the key event was generated
    ctrlKey*: uint8
    ##  whether the Shift key was active when the key event was generated
    shiftKey*: uint8

  LCUI_MouseMotionEvent* {.bycopy.} = object
    x*: cint
    y*: cint
    xrel*: cint
    yrel*: cint

  LCUI_MouseButtonEvent* {.bycopy.} = object
    x*: cint
    y*: cint
    button*: cint

  LCUI_MouseWheelEvent* {.bycopy.} = object
    x*: cint
    y*: cint
    delta*: cint

  LCUI_TouchEvent* {.bycopy.} = object
    nPoints*: cint
    points*: LCUI_TouchPoint

  LCUI_TextInputEvent* {.bycopy.} = object
    text*: WideCString 
    length*: csize_t

  LCUI_SysEventRec* {.bycopy.} = object
    `type`*: uint32
    data*: pointer
    anoMain3*: INNER_C_UNION_main_2

  LCUI_SysEvent* = ptr LCUI_SysEventRec
  LCUI_SysEventFunc* = proc (a1: LCUI_SysEvent; a2: pointer) {.cdecl.}
  LCUI_AppDriverId* = enum
    LCUI_APP_UNKNOWN, LCUI_APP_LINUX, LCUI_APP_LINUX_X11, LCUI_APP_WINDOWS,
    LCUI_APP_UWP


##  LCUI 应用程序驱动接口，封装了各个平台下的应用程序相关功能支持接口

type
  LCUI_AppDriverRec* {.bycopy.} = object
    id*: LCUI_AppDriverId
    processEvents*: proc () {.cdecl.}
    bindSysEvent*: proc (a1: cint; a2: LCUI_EventFunc; a3: pointer;
                       a4: proc (a1: pointer) {.cdecl.}): cint {.cdecl.}
    unbindSysEvent*: proc (a1: cint; a2: LCUI_EventFunc): cint {.cdecl.}
    unbindSysEvent2*: proc (a1: cint): cint {.cdecl.}
    getData*: proc (): pointer {.cdecl.}

  LCUI_AppDriver* = ptr LCUI_AppDriverRec

  LCUI_MainLoop* = pointer

proc bindEvent*(id: cint; `func`: LCUI_SysEventFunc; data: pointer;
                    destroyData: proc (a1: pointer) {.cdecl.}): cint {.lcui,
    importc: "LCUI_BindEvent".}
proc unbindEvent*(handlerId: cint): cint {.lcui, importc: "LCUI_UnbindEvent".}
proc triggerEvent*(e: LCUI_SysEvent; arg: pointer): cint {.lcui,
    importc: "LCUI_TriggerEvent".}
proc createTouchEvent*(e: LCUI_SysEvent; points: LCUI_TouchPoint; nPoints: cint): cint {.
    lcui, importc: "LCUI_CreateTouchEvent".}
proc destroyEvent*(e: LCUI_SysEvent) {.lcui, importc: "LCUI_DestroyEvent".}
proc bindSysEvent*(eventId: cint; `func`: LCUI_EventFunc; data: pointer;
                       destroyData: proc (a1: pointer) {.cdecl.}): cint {.lcui,
    importc: "LCUI_BindSysEvent".}
proc unbindSysEvent*(eventId: cint; `func`: LCUI_EventFunc): cint {.lcui,
    importc: "LCUI_UnbindSysEvent".}
proc getAppData*(): pointer {.lcui, importc: "LCUI_GetAppData".}
proc getAppId*(): LCUI_AppDriverId {.lcui, importc: "LCUI_GetAppId".}
##  处理当前所有事件

proc processEvents*(): csize_t {.lcui, importc: "LCUI_ProcessEvents".}
##
##  添加任务
##  该任务将会添加至主线程中执行
##

proc postTask*(task: LCUI_Task): uint8 {.lcui, importc: "LCUI_PostTask".}
##
##  添加异步任务
##  该任务将会添加至指定 id 的工作线程中执行
##  @param[in] task 任务数据
##  @param[in] target_worker_id 目标工作线程的编号
##

proc postAsyncTaskTo*(task: LCUI_Task; targetWorkerId: cint) {.lcui,
     importc: "LCUI_PostAsyncTaskTo".}
##
##  添加异步任务
##  该任务将会添加至工作线程中执行
##

proc postAsyncTask*(task: LCUI_Task): cint {.lcui,
     importc: "LCUI_PostAsyncTask".}
##  LCUI_PostTask 的简化版本

template lCUI_PostSimpleTask*(`func`, arg1, arg2: untyped): void =
  while true:
    var uiTask: LCUI_TaskRec = [0]
    uiTask.arg[0] = cast[pointer](arg1)
    uiTask.arg[1] = cast[pointer](arg2)
    uiTask.`func` = (lCUI_AppTaskFunc)(`func`)
    lCUI_PostTask(addr(uiTask))
    if not 0:
      break

proc runFrame*() {.lcui, importc: "LCUI_RunFrame".}
proc runFrameWithProfile*(profile: LCUI_FrameProfile) {.lcui,
    importc: "LCUI_RunFrameWithProfile".}
##  新建一个主循环

proc mainLoopNew*(): LCUI_MainLoop {.lcui, importc: "LCUIMainLoop_New".}
##  运行目标循环

proc mainLoopRun*(loop: LCUI_MainLoop): cint {.lcui, importc: "LCUIMainLoop_Run".}
##  标记目标主循环需要退出

proc mainLoopQuit*(loop: LCUI_MainLoop) {.lcui, importc: "LCUIMainLoop_Quit".}
proc mainLoopDestroy*(loop: LCUI_MainLoop) {.lcui,
    importc: "LCUIMainLoop_Destroy".}
##  检测LCUI是否活动

proc isActive*(): uint8 {.lcui, importc: "LCUI_IsActive".}
##  获取当前帧数

proc getFrameCount*(): cint {.lcui, importc: "LCUI_GetFrameCount".}
proc initBase*() {.lcui, importc: "LCUI_InitBase".}
proc initApp*(app: LCUI_AppDriver) {.lcui, importc: "LCUI_InitApp".}
##  初始化 LCUI 各项功能

proc lcuiInit*() {.lcui, importc: "LCUI_Init".}
##
##  进入 LCUI 主循环
##  调用该函数后，LCUI 会将当前线程作为 UI 线程，用于处理部件更新、布局、渲染等
##  与图形界面相关的任务。
##

proc lcuiMain*(): cint {.lcui, importc: "LCUI_Main".}
##  获取LCUI的版本

proc lcuiGetVersion*(): cstring {.lcui, importc: "LCUI_GetVersion".}
##  释放LCUI占用的资源

proc lcuiDestroy*(): cint {.lcui, importc: "LCUI_Destroy".}
##  退出LCI，释放LCUI占用的资源

proc lcuiQuit*() {.lcui, importc: "LCUI_Quit".}
##  退出 LCUI，并设置退出码

proc lcuiExit*(code: cint) {.lcui, importc: "LCUI_Exit".}
##  检测当前是否在主线程上

proc lcuiIsOnMainLoop*(): uint8 {.lcui, importc: "LCUI_IsOnMainLoop".}
##  LCUI_END_HEADER
