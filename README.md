b2g-desktop-profile-installer
=============================

b2g-desktop builds for windows do not include a GaiaUI i.e. all of the apps including the homescreen. 
In order to get the actual user interface you need to compile the GaiaUI and the build scripts only work on linux/mac
at the moment. This project uses http://nsis.sourceforge.net/ to create an installer that allows windows users
to try out b2g without having to have access to a mac / linux box or have to use a virtual machine.

For a quick test of b2g:
------------------------

install-gaia.exe will install the GaiaUI into a b2g-desktop that you have downloaded from http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/.
install-b2g.exe will install b2g and GaiaUI in one go. Note this file is not automatically built nightly so it will contain an outdated version.

To build the installer yourself:
--------------------------------

1) install nsis from http://nsis.sourceforge.net/

2) Clone or download https://github.com/sihorton/b2g-desktop-profile-installer/ into installer/

3) clone or download https://github.com/sihorton/b2g-desktop-profile/ into b2g-desktop-profile/

4) extract b2g-desktop build to b2g-extract/

Compile build-installer-b2g.nsi (install-b2g.exe) or build-istaller-gaiaui.nsi (install-gaia.exe).
To create an updated build just get updates from b2g-desktop-profile and extract b2g from a new download.

----------

If you are running 64-bit windows and get an error message saying "MSVCP100.dll missing" when running b2g-desktop then you will need to install the Microsoft Visual C++ 2010 Redistributable Package (x86). This is available for free from the following link: http://www.microsoft.com/download/en/confirmation.aspx?id=5555