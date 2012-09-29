/**
* launch boot2gecko and check for updates.
*/
!define PRODUCT_NAME "b2g-gaia-desktop"
!define PRODUCT_VERSION "0.6"
!define PRODUCT_PUBLISHER "sihorton"
!define PROFILE_DIR_DEST "gaia"
!define NEW_VERSION_URL "https://raw.github.com/sihorton/b2g-desktop-profile-installer/master/version.txt"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

!include "SupportFunctions.nsi"

RequestExecutionLevel user
Name "${PRODUCT_NAME}"
OutFile "b2g-desktop.exe"
Icon "b2g.ico"
ShowInstDetails hide

Function .onInit
    SetSilent silent
 FunctionEnd

Section "MainSection" SEC01
    Var /GLOBAL MyPath
    Var /GLOBAL InstalledVersion
    Var /GLOBAL AvailableVersion
    Var /GLOBAL NewInstaller

    ;HideWindow
    Push "$EXEPATH"
    Call GetParent
    Pop $MyPath

    Exec '$MYPATH\b2g.exe -profile "${PROFILE_DIR_DEST}"'

    Push "NOUPDATE"      ; push the search string onto the stack
    Push "checkupdates"   ; push a default value onto the stack
    Call GetParameterValue
    Pop $2

    StrCmp $2 "checkupdates" checkupdates nothingnew
checkupdates:
    ;download version info
    inetc::get /SILENT  "${NEW_VERSION_URL}" "$TEMP\version-latest.txt"

    ;get versions
    IfFileExists "$TEMP\version-latest.txt" +1 nothingnew
    FileOpen $4 "$TEMP\version-latest.txt" r
    FileRead $4 $AvailableVersion
    FileRead $4 $NewInstaller
    FileClose $4
    
    FileOpen $4 "$MyPath\version.txt" r
    FileRead $4 $InstalledVersion
    FileClose $4
    
    ${Trim} $AvailableVersion $AvailableVersion
    ;MessageBox MB_OK "Installed Version: $InstalledVersion Available: $AvailableVersion $NewInstaller"

    ${VersionCompare} "$InstalledVersion" "$AvailableVersion" $0
    StrCmp $0 "2" +1 nothingnew
    MessageBox MB_YESNO "A new version ($AvailableVersion) of ${PRODUCT_NAME} is available. Would you like to download it?" IDYES +1 IDNO nothingnew

    ;Exec "$MyPath\b2g-update.exe"
    ExecShell open '$MyPath\b2g-update.exe'
    
    nothingnew:
    Quit
SectionEnd

Section -AdditionalIcons
SectionEnd

Section -Post
SectionEnd
