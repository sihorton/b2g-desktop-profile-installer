
Section "Gaia UI" SEC02
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer


  ;Required gkmedias.dll is not part of b2g currently so add file if it is missing.
  IfFileExists "$INSTDIR\gkmedias.dll" skipGkmediasFix doGkmediasFix
  doGkmediasFix:
  File "${PROFILE_DIR_SRC}\gkmedias.dll"
  skipGkmediasFix:
  ;required file is now copied or already existed.

  CreateDirectory "$INSTDIR\${PROFILE_DIR_DEST}"

  ;add readme
  ;File /oname=${PROFILE_DIR_SRC}\install-readme.txt "readme.txt"


  ;Copy in the desktop profile.
  SetOutPath "$INSTDIR\${PROFILE_DIR_DEST}"
  File /r /x ".git" "${PROFILE_DIR_SRC}\"

  SetOutPath "$INSTDIR"
  CreateShortCut "$INSTDIR\b2g-desktop.lnk" "$INSTDIR\b2g.exe" \
  '-profile "${PROFILE_DIR_DEST}"'

SectionEnd