##  LCDesign.h -- LCUI.css main header file.
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

import std/widestrs

import ../lcui, ../gui/widget

include incl

proc lCDesignInitAlert*() {.lcdesign, importc: "LCDesign_InitAlert".}

proc lCDesignInitLabel*() {.lcdesign, importc: "LCDesign_InitLabel".}

proc iconSetName*(w: LCUI_Widget; name: cstring): cint {.lcdesign, importc: "Icon_SetName".}
proc lCDesignInitIcon*() {.lcdesign, importc: "LCDesign_InitIcon".}

proc lCDesignInitCheckBox*() {.lcdesign, importc: "LCDesign_InitCheckBox".}
proc checkBoxIsChecked*(w: LCUI_Widget): Lcui_Bool {.lcdesign,
    importc: "CheckBox_IsChecked".}
proc checkBoxSetChecked*(w: LCUI_Widget; checked: Lcui_Bool) {.lcdesign,
    importc: "CheckBox_SetChecked".}

proc radioSetChecked*(w: LCUI_Widget; checked: Lcui_Bool) {.lcdesign,
    importc: "Radio_SetChecked".}
proc lCDesignInitRadio*() {.lcdesign, importc: "LCDesign_InitRadio".}

proc radioGroupSetCheckedRadio*(w: LCUI_Widget; radio: LCUI_Widget): cint {.lcdesign,
    importc: "RadioGroup_SetCheckedRadio".}
proc radioGroupSetValue*(w: LCUI_Widget; value: cstring): cint {.lcdesign,
    importc: "RadioGroup_SetValue".}
proc radioGroupGetValue*(w: LCUI_Widget): cstring {.lcdesign,
    importc: "RadioGroup_GetValue".}
proc lCDesignInitRadioGroup*() {.lcdesign, importc: "LCDesign_InitRadioGroup".}

proc lCDesignInitImg*() {.lcdesign, importc: "LCDesign_InitImg".}

proc rateSetValue*(w: LCUI_Widget; value: cuint) {.lcdesign, importc: "Rate_SetValue".}
proc rateGetValue*(w: LCUI_Widget): cuint {.lcdesign, importc: "Rate_GetValue".}
proc rateSetCount*(w: LCUI_Widget; count: cuint) {.lcdesign, importc: "Rate_SetCount".}
proc rateSetIcon*(w: LCUI_Widget; voidIcon: cstring; icon: cstring) {.lcdesign,
    importc: "Rate_SetIcon".}
proc rateSetCharacter*(w: LCUI_Widget; ch: uint16) {.lcdesign,
    importc: "Rate_SetCharacter".}
proc lCDesignInitRate*() {.lcdesign, importc: "LCDesign_InitRate".}

proc lCDesignInitSpinner*() {.lcdesign, importc: "LCDesign_InitSpinner".}

proc lCDesignInitSwitch*() {.lcdesign, importc: "LCDesign_InitSwitch".}
proc switchIsChecked*(w: LCUI_Widget): Lcui_Bool {.lcdesign, importc: "Switch_IsChecked".}
proc switchSetChecked*(w: LCUI_Widget; checked: Lcui_Bool) {.lcdesign,
    importc: "Switch_SetChecked".}
proc switchSetCheckedText*(w: LCUI_Widget; text: cstring) {.lcdesign,
    importc: "Switch_SetCheckedText".}
proc switchSetUncheckedText*(w: LCUI_Widget; text: cstring) {.lcdesign,
    importc: "Switch_SetUncheckedText".}
proc switchSetCheckedIcon*(w: LCUI_Widget; iconName: cstring) {.lcdesign,
    importc: "Switch_SetCheckedIcon".}
proc switchSetUncheckedIcon*(w: LCUI_Widget; iconName: cstring) {.lcdesign,
    importc: "Switch_SetUncheckedIcon".}

proc lCDesignInitTooltip*() {.lcdesign, importc: "LCDesign_InitTooltip".}

proc lCDesignInitPassword*() {.lcdesign, importc: "LCDesign_InitPassword".}

proc lCDesignInitTypograhy*() {.lcdesign, importc: "LCDesign_InitTypograhy".}

proc lCDesignInitModal*() {.lcdesign, importc: "LCDesign_InitModal".}
proc modalShow*(w: LCUI_Widget) {.lcdesign, importc: "Modal_Show".}
proc modalHide*(w: LCUI_Widget) {.lcdesign, importc: "Modal_Hide".}

type
  LCDesignMessageConfigRec* {.bycopy.} = object
    ##  Customized Icon
    icon*: LCUI_Widget
    ##  content of the message
    content*: WideCString
    ##  time(milliseconds) before auto-dismiss, don't dismiss if set to 0
    duration*: clong

  LCDesignMessageConfig* = ptr LCDesignMessageConfigRec

proc lCDesignSetMessageContainer*(w: LCUI_Widget) {.lcdesign,
    importc: "LCDesign_SetMessageContainer".}
proc lCDesignOpenMessage*(config: LCDesignMessageConfig): LCUI_Widget {.lcdesign,
    importc: "LCDesign_OpenMessage".}
proc lCDesignCloseMessage*(message: LCUI_Widget) {.lcdesign,
    importc: "LCDesign_CloseMessage".}
proc lCDesignOpenSuccessMessage*(content: WideCString; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenSuccessMessage".}
proc lCDesignOpenInfoMessage*(content: WideCString; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenInfoMessage".}
proc lCDesignOpenWarningMessage*(content: WideCString; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenWarningMessage".}
proc lCDesignOpenErrorMessage*(content: WideCString; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenErrorMessage".}
proc lCDesignOpenLoadingMessage*(content: WideCString; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenLoadingMessage".}
proc lCDesignInitMessage*() {.lcdesign, importc: "LCDesign_InitMessage".}

type
  LCDesignNotificationConfigRec* {.bycopy.} = object
    ##  Customized Icon
    icon*: LCUI_Widget
    ##  The title of notification box (required)
    title*: WideCString
    ##  The content of notification box (required)
    description*: WideCString
    ##  Position of Notification, can be one of top-left, top-right,
    ##  bottom-left, bottom-right
    placement*: cstring
    ##  time(milliseconds) before auto-dismiss, don't dismiss if set to 0
    duration*: clong

  LCDesignNotificationConfig* = ptr LCDesignNotificationConfigRec

proc lCDesignSetNotificationContainer*(w: LCUI_Widget) {.lcdesign,
    importc: "LCDesign_SetNotificationContainer".}
proc lCDesignOpenNotification*(config: LCDesignNotificationConfig): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenNotification".}
proc lCDesignCloseNotification*(message: LCUI_Widget) {.lcdesign,
    importc: "LCDesign_CloseNotification".}
proc lCDesignOpenNormalNotification*(title: WideCString; description: WideCString;
                                    placement: cstring; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenNormalNotification".}
proc lCDesignOpenSuccessNotification*(title: WideCString; description: WideCString;
                                     placement: cstring; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenSuccessNotification".}
proc lCDesignOpenInfoNotification*(title: WideCString; description: WideCString;
                                  placement: cstring; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenInfoNotification".}
proc lCDesignOpenWarningNotification*(title: WideCString; description: WideCString;
                                     placement: cstring; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenWarningNotification".}
proc lCDesignOpenErrorNotification*(title: WideCString; description: WideCString;
                                   placement: cstring; duration: clong): LCUI_Widget {.
    lcdesign, importc: "LCDesign_OpenErrorNotification".}
proc lCDesignInitNotification*() {.lcdesign, importc: "LCDesign_InitNotification".}

proc lCDesignInitDropdown*() {.lcdesign, importc: "LCDesign_InitDropdown".}
proc dropdownHide*(w: LCUI_Widget) {.lcdesign, importc: "Dropdown_Hide".}
proc dropdownShow*(w: LCUI_Widget) {.lcdesign, importc: "Dropdown_Show".}
proc dropdownBindTarget*(w: LCUI_Widget; target: LCUI_Widget) {.lcdesign,
    importc: "Dropdown_BindTarget".}
proc dropdownToggle*(w: LCUI_Widget) {.lcdesign, importc: "Dropdown_Toggle".}
proc dropdownSetPosition*(w: LCUI_Widget; position: LCUI_StyleValue) {.lcdesign,
    importc: "Dropdown_SetPosition".}

const
  LCDESIGN_VERSION_STRING* = "1.1.0"

proc lCDesignInitDismiss*() {.lcdesign, importc: "LCDesign_InitDismiss".}

proc lCDesignInitToggle*() {.lcdesign, importc: "LCDesign_InitToggle".}

proc lCDesignInit*() {.lcdesign, importc: "LCDesign_Init".}
proc lCDesignGetVersion*(): cstring {.lcdesign, importc: "LCDesign_GetVersion".}

export widget