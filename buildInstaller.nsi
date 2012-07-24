;NSIS script to install gaia profile to b2g directory.
;Authors: Simon Horton
/*
* To setup your own build:
* git clone https://github.com/sihorton/b2g-desktop-profile into ../b2g-desktop-profile
*/

!define PRODUCT_NAME "boot2gecko profile"
!define PRODUCT_VERSION "0.1"
!define PRODUCT_PUBLISHER "Simon Horton"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\AppMainExe.exe"
!define PROFILE_DIR_SRC "b2g-desktop-profile"
!define PROFILE_DIR_DEST "b2g-desktop-profile"
!include "MUI2.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"

; Welcome page
Caption "boot2gecko profile"
!define MUI_WELCOMEPAGE_TITLE 'boot2gecko profile'
!define MUI_TEXT_WELCOME_INFO_TEXT "b2g desktop does not include a gaia profile (the phone interface) at this time. The build scripts currently require linux / mac to run. Therefore this installer provides a pre-built gaia profile for windows users."
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
OutFile "Install.exe"
InstallDir "[select b2g directory]"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show

Section "desktop-profile" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer


  ;Required gkmedias.dll is not part of b2g currently so add file if it is missing.
  IfFileExists "$INSTDIR\gkmedias.dll" skipGkmediasFix doGkmediasFix
  doGkmediasFix:
  File "../${PROFILE_DIR_SRC}\gkmedias.dll"
  skipGkmediasFix:
  ;required file is now copied or already existed.
  
  CreateDirectory "$INSTDIR\${PROFILE_DIR_DEST}"

  ;add readme
  ;File /oname=${PROFILE_DIR_SRC}\install-readme.txt "readme.txt"


  ;Copy in the desktop profile.
  SetOutPath "$INSTDIR\${PROFILE_DIR_DEST}"
  File /r /x ".git" "..\${PROFILE_DIR_SRC}\"

  SetOutPath "$INSTDIR"
  CreateShortCut "$INSTDIR\b2g-profile.lnk" "$INSTDIR\b2g.exe" \
  '-profile "${PROFILE_DIR_DEST}"'

SectionEnd

Section -Post
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} ""
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function Launch-b2g
  ExecShell "" "$INSTDIR\b2g-profile.lnk"
FunctionEnd