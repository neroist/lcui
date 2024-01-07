# Copyright (c) 2024 neroist
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

import lcui

include incl

proc fontconfigGetPath*(name: cstring): cstring {.lcui,
    importc: "Fontconfig_GetPath".}


##  LCUI_BEGIN_HEADER

type
  LCUI_FontStyle* = enum
    FONT_STYLE_NORMAL, FONT_STYLE_ITALIC, FONT_STYLE_OBLIQUE, FONT_STYLE_TOTAL_NUM
  LCUI_FontWeight* = enum
    FONT_WEIGHT_NONE = 0, FONT_WEIGHT_TOTAL_NUM = 9, FONT_WEIGHT_THIN = 100,
    FONT_WEIGHT_EXTRA_LIGHT = 200, FONT_WEIGHT_LIGHT = 300, FONT_WEIGHT_NORMAL = 400,
    FONT_WEIGHT_MEDIUM = 500, FONT_WEIGHT_SEMI_BOLD = 600, FONT_WEIGHT_BOLD = 700,
    FONT_WEIGHT_EXTRA_BOLD = 800, FONT_WEIGHT_BLACK = 900



##  字体位图数据

type
  LCUI_FontBitmap* {.bycopy.} = object
    top*: cint
    ## < 与顶边框的距离
    left*: cint
    ## < 与左边框的距离
    width*: cint
    ## < 位图宽度
    rows*: cint
    ## < 位图行数
    pitch*: cint
    buffer*: ptr uint8
    ## < 字体位图数据
    numGrays*: cshort
    pixelMode*: char
    advance*: LCUI_Pos
    ## < XY轴的跨距

  LCUI_FontRec* {.bycopy.} = object
    id*: cint
    ## < 字体信息ID
    styleName*: cstring
    ## < 样式名称
    familyName*: cstring
    ## < 字族名称
    data*: pointer
    ## < 相关数据
    style*: LCUI_FontStyle
    ## < 风格
    weight*: LCUI_FontWeight
    ## < 粗细程度
    engine*: ptr LCUI_FontEngine
    ## < 所属的字体引擎

  LCUI_Font* = ptr LCUI_FontRec
  LCUI_FontEngine* {.bycopy.} = object
    name*: array[64, char]
    open*: proc (a1: cstring; a2: ptr ptr LCUI_Font): cint {.cdecl.}
    render*: proc (a1: ptr LCUI_FontBitmap; a2: char; a3: cint; a4: LCUI_Font): cint {.
        cdecl.} # as: wide char
    close*: proc (a1: pointer) {.cdecl.}


##
##  根据字符串内容猜测字体粗细程度
##  文档：https://developer.mozilla.org/en-US/docs/Web/CSS/font-weight
##

proc fontDetectWeight*(str: cstring): LCUI_FontWeight {.lcui,
    importc: "LCUIFont_DetectWeight".}
##
##  根据字符串内容猜测字体风格
##  文档：https://developer.mozilla.org/en-US/docs/Web/CSS/font-style
##

proc fontDetectStyle*(str: cstring): LCUI_FontStyle {.lcui,
    importc: "LCUIFont_DetectStyle".}
when not defined(XTYPEDEF_FONT):
  proc font*(familyName: cstring; styleName: cstring): LCUI_Font {.lcui,
      importc: "Font".}
proc deleteFont*(font: LCUI_Font) {.lcui, importc: "DeleteFont".}
proc fontInitInCoreFont*(engine: ptr LCUI_FontEngine): cint {.lcui,
    importc: "LCUIFont_InitInCoreFont".}
proc fontExitInCoreFont*(): cint {.lcui, importc: "LCUIFont_ExitInCoreFont".}
when defined(LCUI_FONT_ENGINE_FREETYPE):
  proc fontInitFreeType*(engine: ptr LCUI_FontEngine): cint {.lcui,
      importc: "LCUIFont_InitFreeType".}
  proc fontExitFreeType*(): cint {.lcui, importc: "LCUIFont_ExitFreeType".}
##  获取内置的 Inconsolata 字体位图

proc fontInconsolataGetBitmap*(bmp: ptr LCUI_FontBitmap; ch: char; size: cint): cint {.
    lcui, importc: "FontInconsolata_GetBitmap".} # ch is wide char
##  打印字体位图的信息

proc fontBitmapPrintInfo*(bitmap: ptr LCUI_FontBitmap) {.lcui,
    importc: "FontBitmap_PrintInfo".}
##  初始化字体位图

proc fontBitmapInit*(bitmap: ptr LCUI_FontBitmap) {.lcui, importc: "FontBitmap_Init".}
##  释放字体位图占用的资源

proc fontBitmapFree*(bitmap: ptr LCUI_FontBitmap) {.lcui, importc: "FontBitmap_Free".}
##  创建字体位图

proc fontBitmapCreate*(bitmap: ptr LCUI_FontBitmap; width: cint; rows: cint): cint {.
    lcui, importc: "FontBitmap_Create".}
##  在屏幕打印以0和1表示字体位图

proc fontBitmapPrint*(fontbmp: ptr LCUI_FontBitmap): cint {.lcui,
    importc: "FontBitmap_Print".}
##  将字体位图绘制到目标图像上

proc fontBitmapMix*(graph: ptr LCUI_Graph; pos: LCUI_Pos; bmp: ptr LCUI_FontBitmap;
                   color: LCUI_Color): cint {.lcui, importc: "FontBitmap_Mix".}
##  载入字体位图

proc fontRenderBitmap*(buff: ptr LCUI_FontBitmap; ch: char; fontId: cint;
                          pixelSize: cint): cint {.lcui,
    importc: "LCUIFont_RenderBitmap".} # ch is wide char
##  添加字体族，并返回该字族的ID

proc fontAdd*(font: LCUI_Font): cint {.lcui, importc: "LCUIFont_Add".}
##
##  获取字体的ID
##  @param[in] family_name 字族名称
##  @param[in] style 字体风格
##  @param[in] weight 字体粗细程度，若为值 0，则默认为 FONT_WEIGHT_NORMAL
##

proc fontGetId*(familyName: cstring; style: LCUI_FontStyle;
                   weight: LCUI_FontWeight): cint {.lcui, importc: "LCUIFont_GetId".}
##
##  更新当前字体的粗细程度
##  @param[in] font_ids 当前的字体 id 列表
##  @params[in] weight 字体粗细程度
##  @params[out] new_font_ids 更新字体粗细程度后的字体 id 列表
##

proc fontUpdateWeight*(fontIds: ptr cint; weight: LCUI_FontWeight;
                          newFontIds: ptr ptr cint): csize_t {.lcui,
    importc: "LCUIFont_UpdateWeight".}
##
##  更新当前字体的风格
##  @param[in] font_ids 当前的字体 id 列表
##  @params[in] style 字体风格
##  @params[out] new_font_ids 更新字体粗细程度后的字体 id 列表
##

proc fontUpdateStyle*(fontIds: ptr cint; style: LCUI_FontStyle;
                         newFontIds: ptr ptr cint): csize_t {.lcui,
    importc: "LCUIFont_UpdateStyle".}
##
##  根据字族名称获取对应的字体 ID 列表
##  @param[out] ids 输出的字体 ID 列表
##  @param[in] style 风格
##  @param[in] weight 字重，若为值 0，则默认为 FONT_WEIGHT_NORMAL
##  @param[in] names 字族名称，多个名字用逗号隔开
##  @return 获取到的字体 ID 的数量
##

proc fontGetIdByNames*(fontIds: ptr ptr cint; style: LCUI_FontStyle;
                          weight: LCUI_FontWeight; names: cstring): csize_t {.lcui,
    importc: "LCUIFont_GetIdByNames".}
##  获取指定字体ID的字体信息

proc fontGetById*(id: cint): LCUI_Font {.lcui, importc: "LCUIFont_GetById".}
##  获取默认的字体ID

proc fontGetDefault*(): cint {.lcui, importc: "LCUIFont_GetDefault".}
##  设定默认的字体

proc fontSetDefault*(id: cint) {.lcui, importc: "LCUIFont_SetDefault".}
##
##  向字体缓存中添加字体位图
##  @param[in] ch 字符码
##  @param[in] font_id 使用的字体ID
##  @param[in] size 字体大小（单位为像素）
##  @param[out] bmp 要添加的字体位图
##  @warning 此函数仅仅是将 bmp 复制进缓存中，并未重新分配新的空间储存位图数
##  据，因此，请勿在调用此函数后手动释放 bmp。
##

proc fontAddBitmap*(ch: char; fontId: cint; size: cint; bmp: ptr LCUI_FontBitmap): ptr LCUI_FontBitmap {.
    lcui, importc: "LCUIFont_AddBitmap".} # ch is wide char
##
##  从缓存中获取字体位图
##  @param[in] ch 字符码
##  @param[in] font_id 使用的字体ID
##  @param[in] size 字体大小（单位为像素）
##  @param[out] bmp 输出的字体位图的引用
##  @warning 请勿释放 bmp，bmp 仅仅是引用缓存中的字体位图，并未建分配新
##  空间存储字体位图的拷贝。
##

proc fontGetBitmap*(ch: char; fontId: cint; size: cint;
                       bmp: ptr ptr LCUI_FontBitmap): cint {.lcui,
    importc: "LCUIFont_GetBitmap".} # ch is char
##  载入字体至数据库中

proc fontLoadFile*(filepath: cstring): cint {.lcui, importc: "LCUIFont_LoadFile".}
##  初始化字体处理模块

proc initFontLibrary*() {.lcui, importc: "LCUI_InitFontLibrary".}
##  停用字体处理模块

proc freeFontLibrary*() {.lcui, importc: "LCUI_FreeFontLibrary".}
##  LCUI_END_HEADER

type
  LCUI_TextStyleRec* {.bycopy.} = object
    hasFamily* {.bitsize: 1.}: Lcui_Bool
    hasStyle* {.bitsize: 1.}: Lcui_Bool
    hasWeight* {.bitsize: 1.}: Lcui_Bool
    hasBackColor* {.bitsize: 1.}: Lcui_Bool
    hasForeColor* {.bitsize: 1.}: Lcui_Bool
    hasPixelSize* {.bitsize: 1.}: Lcui_Bool
    style*: cint
    weight*: cint
    fontIds*: ptr cint
    foreColor*: LCUI_Color
    backColor*: LCUI_Color
    pixelSize*: cint

  LCUI_TextStyle* = ptr LCUI_TextStyleRec

##  初始化字体样式数据

proc textStyleInit*(data: LCUI_TextStyle) {.lcui, importc: "TextStyle_Init".}
proc textStyleCopyFamily*(dst: LCUI_TextStyle; src: LCUI_TextStyle): cint {.lcui,
    importc: "TextStyle_CopyFamily".}
proc textStyleCopy*(dst: LCUI_TextStyle; src: LCUI_TextStyle): cint {.lcui,
    importc: "TextStyle_Copy".}
proc textStyleDestroy*(data: LCUI_TextStyle) {.lcui, importc: "TextStyle_Destroy".}
proc textStyleMerge*(base: LCUI_TextStyle; target: LCUI_TextStyle) {.lcui,
    importc: "TextStyle_Merge".}
##  设置字体粗细程度

proc textStyleSetWeight*(ts: LCUI_TextStyle; weight: LCUI_FontWeight): cint {.lcui,
    importc: "TextStyle_SetWeight".}
proc textStyleSetStyle*(ts: LCUI_TextStyle; style: LCUI_FontStyle): cint {.lcui,
    importc: "TextStyle_SetStyle".}
##
##  设置字体
##  @param[in][out] ts 字体样式数据
##  @param[in] str 字体名称，如果有多个名称则用逗号分隔
##

proc textStyleSetFont*(ts: LCUI_TextStyle; str: cstring): cint {.lcui,
    importc: "TextStyle_SetFont".}
proc textStyleSetSize*(ts: LCUI_TextStyle; pixelSize: cint) {.lcui,
    importc: "TextStyle_SetSize".}
proc textStyleSetForeColor*(ts: LCUI_TextStyle; color: LCUI_Color) {.lcui,
    importc: "TextStyle_SetForeColor".}
proc textStyleSetBackColor*(ts: LCUI_TextStyle; color: LCUI_Color) {.lcui,
    importc: "TextStyle_SetBackColor".}
##  设置使用默认的字体

proc textStyleSetDefaultFont*(ts: LCUI_TextStyle): cint {.lcui,
    importc: "TextStyle_SetDefaultFont".}
## -------------------------- StyleTag --------------------------------
proc styleTagsInit*(list: ptr LinkedList) = linkedListInit(list)

##  从字符串中获取样式标签的名字及样式属性

proc scanStyleTag*(wstr: WideCString; name: WideCString; maxNameLen: cint; data: WideCString): WideCString {.
    lcui, importc: "ScanStyleTag".}
##  在字符串中获取样式的结束标签，输出的是标签名

proc scanStyleEndingTag*(wstr: WideCString; name: WideCString): WideCString {.lcui,
    importc: "ScanStyleEndingTag".}
proc styleTagsClear*(tags: ptr LinkedList) {.lcui, importc: "StyleTags_Clear".}
proc styleTagsGetTextStyle*(tags: ptr LinkedList): LCUI_TextStyle {.lcui,
    importc: "StyleTags_GetTextStyle".}
##  处理样式标签

proc styleTagsGetStart*(tags: ptr LinkedList; str: WideCString): WideCString {.lcui,
    importc: "StyleTags_GetStart".}
##  处理样式结束标签

proc styleTagsGetEnd*(tags: ptr LinkedList; str: WideCString): WideCString {.lcui,
    importc: "StyleTags_GetEnd".}
## ------------------------- End StyleTag -----------------------------
##  LCUI_END_HEADER

type
  LCUI_TextCharRec* {.bycopy.} = object
    code*: char # WcharT
    ## < 字符码
    ##style*: LCUI_TextStyle
    ## < 该字符使用的样式数据
    bitmap*: ptr LCUI_FontBitmap
    ## < 字体位图数据(只读)

  LCUI_TextChar* = ptr LCUI_TextCharRec

##  End Of Line character

type
  LCUI_EOLChar* = enum
    LCUI_EOL_NONE,            ## < 无换行
    LCUI_EOL_CR,              ## < Mac OS 格式换行，CF = Carriage-Return，字符：\r
    LCUI_EOL_LF,              ## < UNIX/Linux 格式换行，LF = Line-Feed，字符：\r
    LCUI_EOL_CR_LF            ## < Windows 格式换行： \r\n


##  文本行

type
  LCUI_TextRowRec* {.bycopy.} = object
    width*: cint
    ## < 宽度
    height*: cint
    ## < 高度
    textHeight*: cint
    ## < 当前行中最大字体的高度
    length*: cint
    ## < 该行文本长度
    string*: ptr LCUI_TextChar
    ## < 该行文本的数据
    eol*: LCUI_EOLChar
    ## < 行尾结束类型

  LCUI_TextRow* = ptr LCUI_TextRowRec

##  文本行列表

type
  LCUI_TextRowListRec* {.bycopy.} = object
    length*: cint
    ## < 当前总行数
    rows*: ptr LCUI_TextRow
    ## < 每一行文本的数据

  LCUI_TextRowList* = ptr LCUI_TextRowListRec

##
##  word-break mode
##  The word-break mode specifies whether or not the textlayer should
##  insert line breaks wherever the text would otherwise overflow its
##  content box.
##

type
  INNER_C_STRUCT_textlayer_1* {.bycopy.} = object
    updateBitmap*: Lcui_Bool
    ## < 更新文本的字体位图
    updateTypeset*: Lcui_Bool
    ## < 重新对文本进行排版
    typesetStartRow*: cint
    ## < 排版处理的起始行
    redrawAll*: Lcui_Bool
    ## < 重绘所有字体位图

  LCUI_WordBreakMode* = enum
    LCUI_WORD_BREAK_NORMAL, LCUI_WORD_BREAK_BREAK_ALL
  LCUI_TextLayerRec* {.bycopy.} = object
    offsetX*: cint
    ## < X轴坐标偏移量
    offsetY*: cint
    ## < Y轴坐标偏移量
    newOffsetX*: cint
    ## < 新的X轴坐标偏移量
    newOffsetY*: cint
    ## < 新的Y轴坐标偏移量
    insertX*: cint
    ## < 光标所在列数
    insertY*: cint
    ## < 光标所在行数
    width*: cint
    ## < 实际文本宽度
    ##
    ##  固定宽高
    ##  当它们等于0时，文本宽高会根据文本内容自动适应
    ##  当它们大于0时，会直接根据该值处理文本对齐
    ##
    fixedWidth*: cint
    fixedHeight*: cint
    ##
    ##  最大文本宽高
    ##  当未设置固定宽度时，文字排版将按最大宽度进行
    ##
    maxWidth*: cint
    maxHeight*: cint
    length*: csize_t
    ## < 文本长度
    lineHeight*: cint
    ## < 全局文本行高度
    textAlign*: cint
    ## < 文本的对齐方式
    wordBreak*: LCUI_WordBreakMode
    ## < 单词内断行模式
    enableMulitiline*: Lcui_Bool
    ## < 是否启用多行文本模式
    enableAutowrap*: Lcui_Bool
    ## < 是否启用自动换行模式
    enableStyleTag*: Lcui_Bool
    ## < 是否使用文本样式标签
    dirtyRects*: LinkedList
    ## < 脏矩形记录
    textStyles*: LinkedList
    ## < 样式缓存
    textDefaultStyle*: LCUI_TextStyleRec
    ## < 文本全局样式
    textRows*: LCUI_TextRowListRec
    ## < 文本行列表
    task*: INNER_C_STRUCT_textlayer_1
    ## < 待处理的任务

  LCUI_TextLayer* = ptr LCUI_TextLayerRec


##  获取文本行总数

proc textLayerGetRowTotal*(layer: LCUI_TextLayer): cint {.lcui,
    importc: "TextLayer_GetRowTotal".}
##  获取指定文本行的高度

proc textLayerGetRowHeight*(layer: LCUI_TextLayer; row: cint): cint {.lcui,
    importc: "TextLayer_GetRowHeight".}
##  获取指定文本行的文本长度

proc textLayerGetRowTextLength*(layer: LCUI_TextLayer; row: cint): cint {.lcui,
    importc: "TextLayer_GetRowTextLength".}
##  添加 更新文本排版 的任务

proc textLayerAddUpdateTypeset*(layer: LCUI_TextLayer; startRow: cint) {.lcui,
    importc: "TextLayer_AddUpdateTypeset".}
##  设置文本对齐方式

proc textLayerSetTextAlign*(layer: LCUI_TextLayer; align: cint) {.lcui,
    importc: "TextLayer_SetTextAlign".}
##  设置坐标偏移量

proc textLayerSetOffset*(layer: LCUI_TextLayer; offsetX: cint; offsetY: cint): Lcui_Bool {.
    lcui, importc: "TextLayer_SetOffset".}
proc textLayerNew*(): LCUI_TextLayer {.lcui, importc: "TextLayer_New".}
##  销毁TextLayer

proc textLayerDestroy*(layer: LCUI_TextLayer) {.lcui, importc: "TextLayer_Destroy".}
##  标记指定范围内容的文本行的矩形为无效

proc textLayerInvalidateRowsRect*(layer: LCUI_TextLayer; startRow: cint; endRow: cint) {.
    lcui, importc: "TextLayer_InvalidateRowsRect".}
##  设置插入点的行列坐标

proc textLayerSetCaretPos*(layer: LCUI_TextLayer; row: cint; col: cint) {.lcui,
    importc: "TextLayer_SetCaretPos".}
##  根据像素坐标设置文本光标的行列坐标

proc textLayerSetCaretPosByPixelPos*(layer: LCUI_TextLayer; x: cint; y: cint): cint {.
    lcui, importc: "TextLayer_SetCaretPosByPixelPos".}
##  获取指定行列的文字的像素坐标

proc textLayerGetCharPixelPos*(layer: LCUI_TextLayer; row: cint; col: cint;
                              pixelPos: ptr LCUI_Pos): cint {.lcui,
    importc: "TextLayer_GetCharPixelPos".}
##  获取文本光标的像素坐标

proc textLayerGetCaretPixelPos*(layer: LCUI_TextLayer; pixelPos: ptr LCUI_Pos): cint {.
    lcui, importc: "TextLayer_GetCaretPixelPos".}
##  清空文本

proc textLayerClearText*(layer: LCUI_TextLayer) {.lcui,
    importc: "TextLayer_ClearText".}
##  插入文本内容（宽字符版）

proc textLayerInsertTextW*(layer: LCUI_TextLayer; wstr: WideCString;
                          tagStack: ptr LinkedList): cint {.lcui,
    importc: "TextLayer_InsertTextW".}
##  插入文本内容

proc textLayerInsertTextA*(layer: LCUI_TextLayer; str: cstring): cint {.lcui,
    importc: "TextLayer_InsertTextA".}
##  插入文本内容（UTF-8版）

proc textLayerInsertText*(layer: LCUI_TextLayer; utf8Str: cstring): cint {.lcui,
    importc: "TextLayer_InsertText".}
##  追加文本内容（宽字符版）

proc textLayerAppendTextW*(layer: LCUI_TextLayer; wstr: WideCString;
                          tagStack: ptr LinkedList): cint {.lcui,
    importc: "TextLayer_AppendTextW".}
##  追加文本内容

proc textLayerAppendTextA*(layer: LCUI_TextLayer; asciiText: cstring): cint {.lcui,
    importc: "TextLayer_AppendTextA".}
##  追加文本内容（UTF-8版）

proc textLayerAppendText*(layer: LCUI_TextLayer; utf8Text: cstring): cint {.lcui,
    importc: "TextLayer_AppendText".}
##  设置文本内容（宽字符版）

proc textLayerSetTextW*(layer: LCUI_TextLayer; wstr: WideCString;
                       tagStack: ptr LinkedList): cint {.lcui,
    importc: "TextLayer_SetTextW".}
##  设置文本内容

proc textLayerSetTextA*(layer: LCUI_TextLayer; asciiText: cstring): cint {.lcui,
    importc: "TextLayer_SetTextA".}
##  设置文本内容（UTF-8版）

proc textLayerSetText*(layer: LCUI_TextLayer; utf8Text: cstring): cint {.lcui,
    importc: "TextLayer_SetText".}
##  获取文本图层中的文本（宽字符版）

proc textLayerGetTextW*(layer: LCUI_TextLayer; startPos: csize_t; maxLen: csize_t;
                       wstrBuff: WideCString): csize_t {.lcui,
    importc: "TextLayer_GetTextW".}
##  计算并获取文本的宽度

proc textLayerGetWidth*(layer: LCUI_TextLayer): cint {.lcui,
    importc: "TextLayer_GetWidth".}
##  计算并获取文本的高度

proc textLayerGetHeight*(layer: LCUI_TextLayer): cint {.lcui,
    importc: "TextLayer_GetHeight".}
##  设置固定尺寸

proc textLayerSetFixedSize*(layer: LCUI_TextLayer; width: cint; height: cint): cint {.
    lcui, importc: "TextLayer_SetFixedSize".}
##  设置最大尺寸

proc textLayerSetMaxSize*(layer: LCUI_TextLayer; width: cint; height: cint): cint {.
    lcui, importc: "TextLayer_SetMaxSize".}
##  设置是否启用多行文本模式

proc textLayerSetMultiline*(layer: LCUI_TextLayer; enabled: Lcui_Bool) {.lcui,
    importc: "TextLayer_SetMultiline".}
##  删除文本光标的当前坐标右边的文本

proc textLayerTextDelete*(layer: LCUI_TextLayer; nChar: cint): cint {.lcui,
    importc: "TextLayer_TextDelete".}
##  退格删除文本，即删除文本光标的当前坐标左边的文本

proc textLayerTextBackspace*(layer: LCUI_TextLayer; nChar: cint): cint {.lcui,
    importc: "TextLayer_TextBackspace".}
##  设置是否启用自动换行模式

proc textLayerSetAutoWrap*(layer: LCUI_TextLayer; autowrap: Lcui_Bool) {.lcui,
    importc: "TextLayer_SetAutoWrap".}
##  设置单词内断行模式

proc textLayerSetWordBreak*(layer: LCUI_TextLayer; mode: LCUI_WordBreakMode) {.lcui,
    importc: "TextLayer_SetWordBreak".}
##  设置是否使用样式标签

proc textLayerEnableStyleTag*(layer: LCUI_TextLayer; enabled: Lcui_Bool) {.lcui,
    importc: "TextLayer_EnableStyleTag".}
##  重新载入各个文字的字体位图

proc textLayerReloadCharBitmap*(layer: LCUI_TextLayer) {.lcui,
    importc: "TextLayer_ReloadCharBitmap".}
##  更新数据

proc textLayerUpdate*(layer: LCUI_TextLayer; rects: ptr LinkedList) {.lcui,
    importc: "TextLayer_Update".}
##
##  将文本图层中的指定区域的内容绘制至目标图像中
##  @param layer 要使用的文本图层
##  @param area 文本图层中需要绘制的区域
##  @param layer_pos 文本图层在目标图像中的位置
##  @param cavans 目标画布
##

proc textLayerRenderTo*(layer: LCUI_TextLayer; area: LCUI_Rect; layerPos: LCUI_Pos;
                       canvas: ptr LCUI_Graph): cint {.lcui,
    importc: "TextLayer_RenderTo".}
##  清除已记录的无效矩形

proc textLayerClearInvalidRect*(layer: LCUI_TextLayer) {.lcui,
    importc: "TextLayer_ClearInvalidRect".}
##  设置全局文本样式

proc textLayerSetTextStyle*(layer: LCUI_TextLayer; style: LCUI_TextStyle) {.lcui,
    importc: "TextLayer_SetTextStyle".}
##  设置文本行的高度

proc textLayerSetLineHeight*(layer: LCUI_TextLayer; height: cint) {.lcui,
    importc: "TextLayer_SetLineHeight".}
##  LCUI_END_HEADER
