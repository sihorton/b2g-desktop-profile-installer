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

!define PRODUCT_NAME "b2g-gaia-desktop"
!define PRODUCT_VERSION "0.3"
!define PRODUCT_PUBLISHER "sihorton"
!define PRODUCT_WEB_SITE "http://github.com/sihorton/b2g-desktop-profile-installer"

!include "config.nsi"

!macro CreateInternetShortcut FILENAME URL
WriteINIStr "${FILENAME}.url" "InternetShortcut" "URL" "${URL}"
!macroend

; Welcome page
!insertmacro MUI_PAGE_WELCOME

; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!define MUI_DIRECTORYPAGE_TEXT_TOP 'If installing b2g-desktop then select the directory to install to. If you have selected to only instal Gaia UI to an existing b2g-desktop client then select the directory where b2g is installed on your machine.'
!insertmacro MUI_PAGE_DIRECTORY
; Start menu page
var ICONS_GROUP
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "b2g-gaia-desktop"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_TEXT "In b2g-desktop Press [Home] key to return to the homescreen after launching an app."
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Run b2g-desktop"
!define MUI_FINISHPAGE_RUN_FUNCTION "Launch-b2g"
;!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\${PROFILE_DIR_DEST}\install-readme.txt"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES


; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME}"
OutFile "${PRODUCT_NAME}.exe"
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails hide
ShowUnInstDetails hide

Function .onInit
; Check to see if already installed
  ReadRegStr $R0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString"
  ReadRegStr $R1 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallDir"
  IfFileExists $R0 +1 NotInstalled
  MessageBox MB_YESNO "${PRODUCT_NAME} is already installed, should we uninstall the existing version first?" IDYES Uninstall IDNO NotInstalled
Uninstall:
  ExecWait '"$R0" /S _?=$INSTDIR'
  Delete "$R0"
  RmDir "$R1"
NotInstalled:
FunctionEnd

Section "b2g-desktop" SEC01
  SetShellVarContext all
  SetOverwrite ifnewer
  SetOutPath "$INSTDIR"
  CreateDirectory "$INSTDIR"
  File /r /x ".git" "${B2G_DIR_SRC}\"
  File "${PROFILE_DIR_SRC}\gkmedias.dll"
  
; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\${PRODUCT_NAME}.lnk" "$INSTDIR\b2g.exe"
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\b2g.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
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
  CreateShortCut "$INSTDIR\b2g-desktop.lnk" "$INSTDIR\b2g.exe" \
  '-profile "${PROFILE_DIR_DEST}"'



; Shortcuts
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\${PRODUCT_NAME}.lnk" "$INSTDIR\b2g.exe" \
  '-profile "${PROFILE_DIR_DEST}"'
  CreateShortCut "$DESKTOP\${PRODUCT_NAME}.lnk" "$INSTDIR\b2g.exe" \
  '-profile "${PROFILE_DIR_DEST}"'
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -AdditionalIcons
  SetShellVarContext all
  SetOutPath $INSTDIR
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application

  !insertmacro CreateInternetShortcut \
      "$SMPROGRAMS\$ICONS_GROUP\Website.url" \
      "http://github.com/sihorton/b2g-desktop-profile-installer/"

  !insertmacro CreateInternetShortcut \
      "$SMPROGRAMS\$ICONS_GROUP\Boot2Gecko.url" \
      "http://developer.mozilla.org/en/Mozilla/Boot_to_Gecko/"
  
  !insertmacro CreateInternetShortcut \
      "$SMPROGRAMS\$ICONS_GROUP\b2g-desktop downloads.url" \
      "http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/"

  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\uninst.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -Post
  SetShellVarContext all
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\b2g.exe"
  
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "InstallDir" "$INSTDIR"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\b2g.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "an emulator for running boot2gecko on a windows pc."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "Gaia is the user interface (webapps and os user interface) for boot2gecko"
!insertmacro MUI_FUNCTION_DESCRIPTION_END


Function un.onUninstSuccess
  HideWindow
  IfSilent +2 0
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
IfSilent silent noisy
  noisy:
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
  goto ok
  
  silent:
  SetAutoClose true

  ok:
 
FunctionEnd

Section Uninstall
  SetShellVarContext all
  !insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
  
  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  
  RMDir /r "$SMPROGRAMS\$ICONS_GROUP"
  RMDir /r "$INSTDIR\"
  
  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd

Function Launch-b2g
  ExecShell "" "$INSTDIR\b2g-desktop.lnk"
FunctionEnd

