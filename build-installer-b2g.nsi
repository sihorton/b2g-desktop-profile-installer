;NSIS script to install gaia profile to b2g directory.
;Authors: Simon Horton
/*
* To setup your own build:
* git clone https://github.com/sihorton/b2g-desktop-profile into ../b2g-desktop-profile
* extract b2g into ..\b2g-extract
*/

!define PRODUCT_NAME "boot2gecko desktop installer"
!define PRODUCT_VERSION "0.1"
!define PRODUCT_PUBLISHER "Simon Horton"

Caption "boot2gecko installer"
!include "config.nsi"

; Welcome page
;!define MUI_WELCOMEPAGE_TITLE 'boot2gecko install'
;!define MUI_TEXT_WELCOME_INFO_TEXT "This will install a boot2gecko desktop client with built in gaia ui."
!insertmacro MUI_PAGE_WELCOME
; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!define MUI_DIRECTORYPAGE_TEXT_TOP 'If installing the b2g client then select the directory to install to. If installing only the profile then find the directory where b2g is installed on your machine.'

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
OutFile "install-b2g.exe"
InstallDir "[select b2g directory]"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show

!include "b2g-files.nsi"
!include "gaiaui-files.nsi"


Section -Post
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR"
SectionEnd
Function Launch-b2g
  ExecShell "" "$INSTDIR\b2g-profile.lnk"
FunctionEnd