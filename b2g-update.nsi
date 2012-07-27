/**
* launch boot2gecko and check for updates.
*/
!define PRODUCT_NAME "b2g-update"
!define PRODUCT_VERSION "0.3"
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
OutFile "${PRODUCT_NAME}.exe"
Icon "b2g.ico"
;InstallDir "$PROGRAMFILES\DBBackup"
;InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails hide

Section "MainSection" SEC01
    Var /GLOBAL MyPath
    Var /GLOBAL AvailableVersion
    Var /GLOBAL NewInstaller

    Push "$EXEPATH"
    Call GetParent
    Pop $MyPath

    IfFileExists "$MyPath\version-latest.txt" +1 nothingnew
    FileOpen $4 "$MyPath\version-latest.txt" r
    FileRead $4 $AvailableVersion
    FileRead $4 $NewInstaller
    FileClose $4

    inetc::get "$NewInstaller" "$TEMP\UpdateInstall.exe"
    Pop $0
    StrCmp $0 "OK" doinstall error
    error:
     MessageBox MB_OK "Error:$1 when downloading $NewInstaller"
     Abort
     
    doinstall:
      ReadRegStr $R0 ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString"
      IfFileExists $R0 +1 RunUpdate
      ExecWait '"$R0" /S _?=$INSTDIR'

      RunUpdate:
      ExecWait '$TEMP\UpdateInstall.exe'
      Delete "$TEMP\UpdateInstall.exe"
nothingnew:

SectionEnd