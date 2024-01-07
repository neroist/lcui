##
##  metrics.h -- Display related metrics operation set.
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

import ../lcui

include ../incl

type
  LCUI_MetricsRec* {.bycopy.} = object
    dpi*: cfloat
    density*: cfloat
    scaledDensity*: cfloat
    scale*: cfloat

  LCUI_Metrics* = ptr LCUI_MetricsRec
  LCUI_DensityLevel* = enum
    DENSITY_LEVEL_SMALL, DENSITY_LEVEL_NORMAL, DENSITY_LEVEL_LARGE,
    DENSITY_LEVEL_BIG


##  转换成单位为 px 的度量值

proc metricsCompute*(value: cfloat; `type`: LCUI_StyleType): cfloat {.lcui,
    importc: "LCUIMetrics_Compute".}
proc metricsComputeStyle*(style: LCUI_Style): cfloat {.lcui,
    importc: "LCUIMetrics_ComputeStyle".}
##  将矩形中的度量值的单位转换为 px

proc metricsComputeRectActual*(dst: ptr LCUI_Rect; src: ptr LCUI_RectF) {.lcui,
    importc: "LCUIMetrics_ComputeRectActual".}
##  转换成单位为 px 的实际度量值

proc metricsComputeActual*(value: cfloat; `type`: LCUI_StyleType): cint {.lcui,
    importc: "LCUIMetrics_ComputeActual".}
##  获取当前的全局缩放比例

proc metricsGetScale*(): cfloat {.lcui, importc: "LCUIMetrics_GetScale".}
##  设置密度

proc metricsSetDensity*(density: cfloat) {.lcui,
    importc: "LCUIMetrics_SetDensity".}
##  设置缩放密度

proc metricsSetScaledDensity*(density: cfloat) {.lcui,
    importc: "LCUIMetrics_SetScaledDensity".}
##  设置密度等级

proc metricsSetDensityLevel*(level: LCUI_DensityLevel) {.lcui,
    importc: "LCUIMetrics_SetDensityLevel".}
##  设置缩放密度等级

proc metricsSetScaledDensityLevel*(level: LCUI_DensityLevel) {.lcui,
    importc: "LCUIMetrics_SetScaledDensityLevel".}
##  设置 DPI

proc metricsSetDpi*(dpi: cfloat) {.lcui, importc: "LCUIMetrics_SetDpi".}
##  设置全局缩放比例

proc metricsSetScale*(scale: cfloat) {.lcui, importc: "LCUIMetrics_SetScale".}
proc initMetrics*() {.lcui, importc: "LCUI_InitMetrics".}
proc getMetrics*(): ptr LCUI_MetricsRec {.lcui, importc: "LCUI_GetMetrics".}
proc freeMetrics*() {.lcui, importc: "LCUI_FreeMetrics".}
##  LCUI_END_HEADER
