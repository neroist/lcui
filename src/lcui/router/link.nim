import ../gui/widget
import router

{.passL: "LCUIRouter.lib".}

proc routerLinkSetLocation*(w: LCUI_Widget; location: ptr RouterLocationT) {.cdecl,
    importc: "RouterLink_SetLocation".}
proc routerLinkSetExact*(w: LCUI_Widget; exact: RouterBooleanT) {.cdecl,
    importc: "RouterLink_SetExact".}
proc ui_InitRouterLink*() {.cdecl, importc: "UI_InitRouterLink".}