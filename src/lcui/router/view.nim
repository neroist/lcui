import ../gui/widget

{.passL: "LCUIRouter.lib".}

proc routerViewGetMatchedWidget*(w: LCUI_Widget): LCUI_Widget {.cdecl,
    importc: "RouterView_GetMatchedWidget".}
proc ui_InitRouterView*() {.cdecl, importc: "UI_InitRouterView".}