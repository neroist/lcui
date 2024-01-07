import std/widestrs

import
  lcui,
  lcui/gui/widget,
  lcui/gui/builder,
  lcui/gui/widget/textedit,
  lcui/gui/widget/textview

type
  Tdestroy_data* = proc(d: pointer) {.cdecl.}

proc onBtnClick(self: LCUI_Widget, e: LCUI_WidgetEvent, arg: pointer) {.cdecl.}=
  var s = newWideCString("", 256)
  var edit = getById("edit")
  var txt = getById("text-hello")

  textEditGetTextW(edit, 0, 255, s)
  textViewSetTextW(txt, s)


proc main(): int {.discardable.} =
  var root, pack, btn: LCUI_Widget

  lcuiInit()

  root = getRoot()
  pack = builderLoadFile("./helloworld.xml")
  
  if pack == nil:
      return -1
  
  append(root, pack)
  unwrap(pack)
  btn = getById("btn")
  bindEvent(btn, cstring"click",
      cast[LCUI_WidgetEventFunc](onBtnClick),
      cast[pointer](nil), cast[Tdestroy_data](nil)
      )

  return lcuiMain()

main()