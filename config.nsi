
!define B2G_DIR_SRC "..\b2g-extract\b2g"
!define PROFILE_DIR_SRC "..\b2g-desktop-profile"
!define PROFILE_DIR_DEST "b2g-desktop-profile"

;general graphics settings

!include "MUI2.nsh"
; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"

;other settings
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\AppMainExe.exe"
