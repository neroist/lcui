when defined(windows):
  when defined(lcdesignLib):
    {.passL: "LCDesign.lib".}

    {.pragma: lcdesign, cdecl, discardable.}
  else:
    {.pragma: lcdesign, cdecl, discardable, dynlib: "LCDesign.dll".}
