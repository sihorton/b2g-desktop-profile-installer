/**
* launch boot2gecko and check for updates.
*/
!define PRODUCT_NAME "b2g-gaia-desktop"
!define PRODUCT_VERSION "0.4"
!define PRODUCT_PUBLISHER "sihorton"
!define PROFILE_DIR_DEST "gaia"

!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

!include "MUI2.nsh"
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE "English"

!include "SupportFunctions.nsi"

Name "${PRODUCT_NAME}"
OutFile "b2g-desktop.exe"
Icon "b2g.ico"
;InstallDir "$PROGRAMFILES\DBBackup"
;InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
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
    inetc::get /SILENT  "https://raw.github.com/sihorton/b2g-desktop-profile-installer/master/version.txt" "$MyPath\version-latest.txt"

    ;get versions
    IfFileExists "$MyPath\version-latest.txt" +1 nothingnew
    FileOpen $4 "$MyPath\version-latest.txt" r
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

    Exec "$MyPath\b2g-update.exe"
    
    nothingnew:
    ;Pop $0
    ;MessageBox MB_OK "$0"

/*
    NSISdl::download "https://raw.github.com/sihorton/b2g-desktop-profile-installer/master/version.txt" "$R0\latestv.txt"
         Pop $R0 ;Get the return value
        ;StrCmp $R0 "success" +6
MessageBox MB_OK "$R0"
*/
         /*
        ;http://nsis.sourceforge.net/Inetc_plug-in#post_DLL_Function
        inetc::post p=NSIS8542Pass \
        "http://localhost:8086/d4/tro/Prod3/do/Backup.php" \
        "$EXEDIR/$3_$2_$1.db"
        Pop $0
        StrCmp $0 "OK" dlok
        FileOpen $4 "$EXEDIR\Error.log" a
        FileSeek $4 0 END
        FileWrite $4 "$0$\r$\n" ; write error log
        FileClose $4 ; and close the file
        ;MessageBox MB_OK|MB_ICONEXCLAMATION "http upload Error $0" /SD IDOK
        ;MessageBox MB_OK "Download failed: $0"
        Quit
        dlok:

        ;NSISdl::download http://ledaco.com/bokningsdemo/do/Backup.php?script=true "$EXEDIR/$3_$2_$1.sql.zip"
        ;NSISdl::download_quiet http://ledaco.com/bokningsdemo/do/Backup2.php "$EXEDIR/downloaded.txt"
        ;Pop $R0 ;Get the return value
        ;StrCmp $R0 "success" +6
*/
        Quit
SectionEnd

Section -AdditionalIcons
SectionEnd

Section -Post
SectionEnd
