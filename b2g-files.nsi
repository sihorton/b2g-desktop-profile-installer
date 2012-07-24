
Section "b2g-desktop" SEC01
  SetOutPath "$INSTDIR"
  CreateDirectory "$INSTDIR"
  File /r /x ".git" "${B2G_DIR_SRC}\"
  File "${PROFILE_DIR_SRC}\gkmedias.dll"

  CreateShortCut "$INSTDIR\run-b2g-GaiaUI.lnk" "$INSTDIR\b2g.exe"
SectionEnd