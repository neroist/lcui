##
##  input.h -- The input devices handling module of LCUI.
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

include incl

##  clang-format off

const
  LCUI_KEY_BACKSPACE* = 8
  LCUI_KEY_TAB* = 9
  LCUI_KEY_ENTER* = 13
  LCUI_KEY_SHIFT* = 16
  LCUI_KEY_CONTROL* = 17
  LCUI_KEY_ALT* = 18
  LCUI_KEY_CAPITAL* = 20
  LCUI_KEY_ESCAPE* = 27
  LCUI_KEY_SPACE* = ' '
  LCUI_KEY_PAGEUP* = 33
  LCUI_KEY_PAGEDOWN* = 34
  LCUI_KEY_END* = 35
  LCUI_KEY_HOME* = 36
  LCUI_KEY_LEFT* = 37
  LCUI_KEY_UP* = 38
  LCUI_KEY_RIGHT* = 39
  LCUI_KEY_DOWN* = 40
  LCUI_KEY_INSERT* = 45
  LCUI_KEY_DELETE* = 46
  LCUI_KEY_0* = '0'
  LCUI_KEY_1* = '1'
  LCUI_KEY_2* = '2'
  LCUI_KEY_3* = '3'
  LCUI_KEY_4* = '4'
  LCUI_KEY_5* = '5'
  LCUI_KEY_6* = '6'
  LCUI_KEY_7* = '7'
  LCUI_KEY_8* = '8'
  LCUI_KEY_9* = '9'
  LCUI_KEY_A* = 'A'
  LCUI_KEY_B* = 'B'
  LCUI_KEY_C* = 'C'
  LCUI_KEY_D* = 'D'
  LCUI_KEY_E* = 'E'
  LCUI_KEY_F* = 'F'
  LCUI_KEY_G* = 'G'
  LCUI_KEY_H* = 'H'
  LCUI_KEY_I* = 'I'
  LCUI_KEY_J* = 'J'
  LCUI_KEY_K* = 'K'
  LCUI_KEY_L* = 'L'
  LCUI_KEY_M* = 'M'
  LCUI_KEY_N* = 'N'
  LCUI_KEY_O* = 'O'
  LCUI_KEY_P* = 'P'
  LCUI_KEY_Q* = 'Q'
  LCUI_KEY_R* = 'R'
  LCUI_KEY_S* = 'S'
  LCUI_KEY_T* = 'T'
  LCUI_KEY_U* = 'U'
  LCUI_KEY_V* = 'V'
  LCUI_KEY_W* = 'W'
  LCUI_KEY_X* = 'X'
  LCUI_KEY_Y* = 'Y'
  LCUI_KEY_Z* = 'Z'
  LCUI_KEY_SEMICOLON* = 186
  LCUI_KEY_EQUAL* = 187
  LCUI_KEY_COMMA* = 188
  LCUI_KEY_MINUS* = 189
  LCUI_KEY_PERIOD* = 190
  LCUI_KEY_SLASH* = 191
  LCUI_KEY_GRAVE* = 192
  LCUI_KEY_BRACKETLEFT* = 219
  LCUI_KEY_BACKSLASH* = 220
  LCUI_KEY_BRACKETRIGHT* = 221
  LCUI_KEY_APOSTROPHE* = 222
  LCUI_KEY_LEFTBUTTON* = 1
  LCUI_KEY_RIGHTBUTTON* = 2
  LCUI_KSTATE_PRESSED* = 1
  LCUI_KSTATE_RELEASE* = 0

##  clang-format on
##  LCUI_BEGIN_HEADER
##  检测指定键值的按键是否处于按下状态

proc keyboardIsHit*(keyCode: cint): uint8 {.lcui,
    importc: "LCUIKeyboard_IsHit".}
##
##  检测指定键值的按键是否按了两次
##  @param key_code 要检测的按键的键值
##  @param interval_time 该按键倒数第二次按下时的时间与当前时间的最大间隔
##

proc keyboardIsDoubleHit*(keyCode: cint; intervalTime: cint): uint8 {.lcui,
    importc: "LCUIKeyboard_IsDoubleHit".}
##  添加已被按下的按键

proc keyboardHitKey*(keyCode: cint) {.lcui, importc: "LCUIKeyboard_HitKey".}
##  标记指定键值的按键已释放

proc keyboardReleaseKey*(keyCode: cint) {.lcui,
    importc: "LCUIKeyboard_ReleaseKey".}
proc initKeyboard*() {.lcui, importc: "LCUI_InitKeyboard".}
proc freeKeyboard*() {.lcui, importc: "LCUI_FreeKeyboard".}
##  LCUI_END_HEADER
