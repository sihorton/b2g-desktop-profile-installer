/**
* Following NSIS plugins are used..
* - http://nsis.sourceforge.net/mediawiki/images/5/53/KillProcDll%26FindProcDll.zip
* - inetc.dll
*/

!define PRODUCT_VERSION "0.6"
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

VIProductVersion "${PRODUCT_VERSION}.0.0"
VIAddVersionKey ProductName "${PRODUCT_NAME}"
VIAddVersionKey Comments "An installer for boot2gecko / Firefox OS desktop on windows. This includes gaia the webapps / interface so it works out of the box."
;VIAddVersionKey CompanyName company
;VIAddVersionKey LegalCopyright legal
VIAddVersionKey FileDescription "${PRODUCT_NAME}"
VIAddVersionKey FileVersion "${PRODUCT_VERSION}"
VIAddVersionKey ProductVersion "${PRODUCT_VERSION}"
VIAddVersionKey InternalName "${PRODUCT_NAME}"
;VIAddVersionKey LegalTrademarks ""
VIAddVersionKey OriginalFilename "${PRODUCT_NAME}.exe"

