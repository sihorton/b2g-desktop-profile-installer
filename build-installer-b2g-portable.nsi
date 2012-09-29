/**
* Installer for boot2gecko desktop client.
*    This is an unofficial installer for the boot2gecko desktop client (https://wiki.mozilla.org/B2G)
*
* Create the following directory structure:
* installer/ (git clone https://github.com/sihorton/b2g-desktop-profile-installer)
* b2g-desktop-profile/ (git clone https://github.com/sihorton/b2g-desktop-profile)
* b2g-extract (http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/)
*
* @author: sihorton
*/

!define PRODUCT_NAME "b2g-portable"
!define PRODUCT_PUBLISHER "sihorton"
!define PRODUCT_WEB_SITE "http://github.com/sihorton/b2g-desktop-profile-installer"

!include "config.nsi"
LangString "^ComponentsSubText2_NoInstTypes" ${LANG_ENGLISH} "Select components"
LangString "^ComponentsText" ${LANG_ENGLISH} "Check the components you want to have and uncheck the components you don't want to have. $_CLICK"

!macro CreateInternetShortcut FILENAME URL
WriteINIStr "${FILENAME}.url" "InternetShortcut" "URL" "${URL}"
!macroend

; Welcome page
!define MUI_TEXT_WELCOME_INFO_TITLE "Welcome to ${PRODUCT_NAME}"
!define MUI_TEXT_WELCOME_INFO_TEXT "This wizard will help you to extract ${PRODUCT_NAME} to a directory of your choice.$\r$\n$\r$\n$_CLICK"
!insertmacro MUI_PAGE_WELCOME

; Components page
!define MUI_TEXT_COMPONENTS_SUBTITLE "Choose which features of ${PRODUCT_NAME} you want to use."
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
;!define MUI_DIRECTORYPAGE_TEXT_TOP 'If installing b2g-desktop then select the directory to install to. If you have selected to only instal Gaia UI to an existing b2g-desktop client then select the directory where b2g is installed on your machine.'
!define MUI_DIRECTORYPAGE_TEXT_TOP 'Select the directory to install to. If you have selected to only instal Gaia UI to an existing b2g-desktop client then select the directory where b2g is installed on your machine.'

!define MUI_TEXT_DIRECTORY_TITLE "Choose Directory Location"
!define MUI_TEXT_DIRECTORY_SUBTITLE "Choose the folder in which to extract ${PRODUCT_NAME}."
!insertmacro MUI_PAGE_DIRECTORY
; Start menu page
/*
var ICONS_GROUP
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "b2g-gaia-desktop"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP
*/
; Instfiles page
!define MUI_TEXT_INSTALLING_TITLE "Extracting"
!define MUI_TEXT_INSTALLING_SUBTITLE "Please wait while ${PRODUCT_NAME} is being extracted."
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_TEXT_FINISH_INFO_TITLE "${PRODUCT_NAME} is complete."
!define MUI_FINISHPAGE_TEXT "In b2g-desktop Press [Home] key to return to the homescreen after launching an app."
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Run ${PRODUCT_NAME}"
!define MUI_FINISHPAGE_RUN_FUNCTION "Launch-b2g"
;!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\${PROFILE_DIR_DEST}\install-readme.txt"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
;!insertmacro MUI_UNPAGE_INSTFILES


; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME}"
OutFile "${PRODUCT_NAME}_${PRODUCT_VERSION}.exe"
InstallDir "$DOCUMENTS\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails hide
ShowUnInstDetails hide
InstallButtonText "Extract"

Section "b2g-desktop" SEC01
  SetShellVarContext all
  SetOverwrite ifnewer
  SetOutPath "$INSTDIR"
  CreateDirectory "$INSTDIR"
  ;install version info and launch / auto update.
  File /oname=version.txt "version-portable.txt"
  File /oname=b2g-desktop.exe "b2g-desktop-portable.exe"
  File /oname=b2g-update.exe "b2g-portable-update.exe"
  ;install code
  File /r /x ".git" "${B2G_DIR_SRC}\"
  File "${PROFILE_DIR_SRC}\gkmedias.dll"

SectionEnd

Section "Gaia UI" SEC02
  SetShellVarContext all
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer

;Required gkmedias.dll is not part of b2g currently so add file if it is missing.
  IfFileExists "$INSTDIR\gkmedias.dll" skipGkmediasFix doGkmediasFix
  doGkmediasFix:
  File "${PROFILE_DIR_SRC}\gkmedias.dll"
  skipGkmediasFix:
  ;required file is now copied or already existed.

  CreateDirectory "$INSTDIR\${PROFILE_DIR_DEST}"

  ;Copy in the desktop profile.
  SetOutPath "$INSTDIR\${PROFILE_DIR_DEST}"
  File /r /x ".git" /x "install.bat" "${PROFILE_DIR_SRC}\"

  SetOutPath "$INSTDIR"
  
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "an emulator for running boot2gecko on a windows pc."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "Gaia is the user interface (webapps and os user interface) for boot2gecko"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Function Launch-b2g
  ;ExecShell "" "$INSTDIR\b2g-desktop.lnk"
  Exec "$INSTDIR\b2g-desktop.exe /NOUPDATE"
FunctionEnd

