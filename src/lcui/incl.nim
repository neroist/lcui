when defined(windows):
  when defined(lcuiLib):
    {.passL: "LCUI.lib".}
    {.passL: "LCUIMain.lib".}

    {.pragma: lcui, cdecl, discardable.}
  else:
    {.pragma: lcui, cdecl, discardable, dynlib: "LCUI.dll".}
else:
  {.pragma: lcui, cdecl, discardable, dynlib: "libLCUI(|2).so(|.2|.2.0.0)".}