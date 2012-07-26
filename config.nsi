Caption "${PRODUCT_NAME}"

;location of a b2g-desktop installation, download from http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/
!define B2G_DIR_SRC "..\b2g-extract\b2g"
;location of a pre-compiled gaia ui, download from https://github.com/sihorton/b2g-desktop-profile
!define PROFILE_DIR_SRC "..\b2g-desktop-profile"
;name you would like to use for the profile directory.
!define PROFILE_DIR_DEST "gaia"

;general graphics settings

!include "MUI2.nsh"
; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

;other settings
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\b2g-desktop.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"


