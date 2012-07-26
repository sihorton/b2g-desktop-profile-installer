;NSIS script to install gaia profile to b2g directory.
;Authors: Simon Horton
/*
* To setup your own build:
* git clone https://github.com/sihorton/b2g-desktop-profile into ../b2g-desktop-profile
*/

!define PRODUCT_NAME "Gaia UI"
!define PRODUCT_VERSION "0.1"
!define PRODUCT_PUBLISHER "Simon Horton"
!define PRODUCT_WEB_SITE "http://github.com/sihorton/b2g-desktop-profile-installer"

Caption "Gaia UI"

!include "config.nsi"

; Welcome page
!define MUI_WELCOMEPAGE_TITLE 'Gaia UI'
!define MUI_TEXT_WELCOME_INFO_TEXT "b2g-desktop does not include GaiaUI (the firefox OS phone interface - including homescreen) at this time. The build scripts currently require linux / mac to run. Therefore this installer provides a pre-built GaiaUI profile for windows users."
!insertmacro MUI_PAGE_WELCOME
; Components page
;!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!define MUI_TEXT_DIRECTORY_TITLE 'Select b2g desktop directory'
!define MUI_TEXT_DIRECTORY_SUBTITLE ' '
!define MUI_DIRECTORYPAGE_TEXT_TOP 'Please find and select the directory where you have extracted the boot2gecko desktop client.'
!define MUI_DIRECTORYPAGE_TEXT_DESTINATION 'Select b2g directory'

!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Run b2g-desktop"
!define MUI_FINISHPAGE_RUN_FUNCTION "Launch-b2g"
!insertmacro MUI_PAGE_FINISH
;!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\${PROFILE_DIR_DEST}\install-readme.txt"
!insertmacro MUI_PAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME}"
OutFile "install-gaiaui.exe"
InstallDir "[select b2g directory]"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show

!include "gaiaui-files.nsi"

Section -Post
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR"
SectionEnd
Function Launch-b2g
  ExecShell "" "$INSTDIR\b2g-profile.lnk"
FunctionEnd