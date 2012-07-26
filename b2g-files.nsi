
Section "b2g-desktop" SEC01
  SetOutPath "$INSTDIR"
  CreateDirectory "$INSTDIR"
  File /r /x ".git" "${B2G_DIR_SRC}\"
  File "${PROFILE_DIR_SRC}\gkmedias.dll"

  CreateShortCut "$INSTDIR\b2g-desktop.lnk" "$INSTDIR\b2g.exe"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\b2g-desktop.lnk" "$INSTDIR\b2g.exe"

SectionEnd