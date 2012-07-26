b2g-desktop-profile-installer
=============================

Quick Start:
------------

Click the downloads link and download and run the installer. This will install a b2g-desktop client, gaia 
(the firefox os webapps and homescreen that provide the user interface) and get you started out of the box.

https://github.com/downloads/sihorton/b2g-desktop-profile-installer/b2g-gaia-desktop.exe

Background:
-----------

b2g-desktop builds for windows do not include a Gaia component i.e. all of the apps including the homescreen. 
In order to get the actual user interface you need to compile the GaiaUI and the build scripts only work on linux/mac
at the moment. This project uses http://nsis.sourceforge.net/ to create an installer that allows windows users
to try out b2g without having to have access to a mac / linux box or have to use a virtual machine.

Update your install:
--------------------
If you want to try out a newer b2g-desktop build from http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/
extract the download into the b2g-gaia-desktop directory over the existing code.


To build the installer yourself:
--------------------------------

1) install nsis from http://nsis.sourceforge.net/

2) create the following directory structure:
  installer/ (git clone https://github.com/sihorton/b2g-desktop-profile-installer)
  b2g-desktop-profile/ (git clone https://github.com/sihorton/b2g-desktop-profile)
  b2g-extract (http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/)

Compile build-installer-b2g.nsi with nsis.

Notes:
------

If you are running 64-bit windows and get an error message saying "MSVCP100.dll missing" when running b2g-desktop then you will need to install the Microsoft Visual C++ 2010 Redistributable Package (x86). This is available for free from the following link: http://www.microsoft.com/download/en/confirmation.aspx?id=5555
