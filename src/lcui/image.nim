##
##  image.h -- Image read and write operations set
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

import lcui

include incl

type
  LCUI_ImageProgressFunc* = proc (a1: pointer; a2: cfloat) {.cdecl.}
  LCUI_ImageReadFunc* = proc (a1: pointer; a2: pointer; a3: csize_t): csize_t {.cdecl.}
  LCUI_ImageSkipFunc* = proc (a1: pointer; a2: clong) {.cdecl.}
  LCUI_ImageFunc* = proc (a1: pointer) {.cdecl.}

##  图像读取器的类型

type
  LCUI_ImageReaderType* = enum
    LCUI_UNKNOWN_READER, LCUI_PNG_READER, LCUI_JPEG_READER, LCUI_BMP_READER


const
  LCUI_UNKNOWN_IMAGE* = Lcui_Unknown_Reader
  LCUI_PNG_IMAGE* = Lcui_Png_Reader
  LCUI_JPEG_IMAGE* = Lcui_Jpeg_Reader
  LCUI_BMP_IMAGE* = Lcui_Bmp_Reader

template lCUI_SetImageReaderJump*(reader: untyped): untyped =
  (reader).env and setjmp(((reader).env)[])

type
  LCUI_ImageHeaderRec* {.bycopy.} = object
    `type`*: cint
    bitDepth*: cint
    colorType*: cint
    width*: cuint
    height*: cuint

  LCUI_ImageHeader* = ptr LCUI_ImageHeaderRec

##  图像读取器

type
  LCUI_ImageReaderRec* {.bycopy.} = object
    streamData*: pointer
    ## < 自定义的输入流数据
    hasError*: Lcui_Bool
    ## < 是否有错误
    header*: LCUI_ImageHeaderRec
    ## < 图像头部信息
    fnBegin*: LCUI_ImageFunc
    ## < 在开始读取前调用的函数
    fnEnd*: LCUI_ImageFunc
    ## < 在结束读取时调用的函数
    fnRewind*: LCUI_ImageFunc
    ## < 游标重置函数，用于重置当前读取位置到数据流的开头处
    fnRead*: LCUI_ImageReadFunc
    ## < 数据读取函数，用于从数据流中读取数据
    fnSkip*: LCUI_ImageSkipFunc
    ## < 游标移动函数，用于跳过一段数据
    fnProg*: LCUI_ImageProgressFunc
    ## < 用于接收图像读取进度的函数
    progArg*: pointer
    ## < 接收图像读取进度时的附加参数
    `type`*: cint
    ## < 图片读取器类型
    data*: pointer
    ## < 私有数据
    destructor*: proc (a1: pointer) {.cdecl.}
    ## < 私有数据的析构函数
    ## env*: ptr JmpBuf
    ## ## < 堆栈环境缓存的指针，用于 setjump()
    ## envSrc*: JmpBuf
    ## ## < 默认堆栈环境缓存

  LCUI_ImageReader* = ptr LCUI_ImageReaderRec

##  初始化适用于 PNG 图像的读取器

proc initPNGReader*(reader: LCUI_ImageReader): cint {.lcui,
    importc: "LCUI_InitPNGReader".}
##  初始化适用于 JPEG 图像的读取器

proc initJPEGReader*(reader: LCUI_ImageReader): cint {.lcui,
    importc: "LCUI_InitJPEGReader".}
##  初始化适用于 BMP 图像的读取器

proc initBMPReader*(reader: LCUI_ImageReader): cint {.lcui,
    importc: "LCUI_InitBMPReader".}
proc setImageReaderForFile*(reader: LCUI_ImageReader; fp: ptr File) {.lcui,
    importc: "LCUI_SetImageReaderForFile".}
##  创建图像读取器

proc initImageReader*(reader: LCUI_ImageReader): cint {.lcui,
    importc: "LCUI_InitImageReader".}
##  销毁图像读取器

proc destroyImageReader*(reader: LCUI_ImageReader) {.lcui,
    importc: "LCUI_DestroyImageReader".}
proc readPNGHeader*(reader: LCUI_ImageReader): cint {.lcui,
    importc: "LCUI_ReadPNGHeader".}
proc readJPEGHeader*(reader: LCUI_ImageReader): cint {.lcui,
    importc: "LCUI_ReadJPEGHeader".}
proc readBMPHeader*(reader: LCUI_ImageReader): cint {.lcui,
    importc: "LCUI_ReadBMPHeader".}
proc readImageHeader*(reader: LCUI_ImageReader): cint {.lcui,
    importc: "LCUI_ReadImageHeader".}
proc readPNG*(reader: LCUI_ImageReader; graph: ptr LCUI_Graph): cint {.lcui,
    importc: "LCUI_ReadPNG".}
proc readJPEG*(reader: LCUI_ImageReader; graph: ptr LCUI_Graph): cint {.lcui,
    importc: "LCUI_ReadJPEG".}
proc readBMP*(reader: LCUI_ImageReader; graph: ptr LCUI_Graph): cint {.lcui,
    importc: "LCUI_ReadBMP".}
proc readImage*(reader: LCUI_ImageReader; graph: ptr LCUI_Graph): cint {.lcui,
    importc: "LCUI_ReadImage".}
##  将图像数据写入至png文件

proc writePNGFile*(fileName: cstring; graph: ptr LCUI_Graph): cint {.lcui,
    importc: "LCUI_WritePNGFile".}
##  载入指定图片文件的图像数据

proc readImageFile*(filepath: cstring; `out`: ptr LCUI_Graph): cint {.lcui,
    importc: "LCUI_ReadImageFile".}
##  从文件中获取图像尺寸

proc getImageSize*(filepath: cstring; width: ptr cint; height: ptr cint): cint {.
    lcui, importc: "LCUI_GetImageSize".}
##  LCUI_END_HEADER
