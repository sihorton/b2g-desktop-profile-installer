Quick Start:
------------

https://github.com/downloads/sihorton/b2g-desktop-profile-installer/b2g-gaia-desktop.exe

Run the installer and it will setup b2g-desktop, gaia and dependancies for you and then run b2g-desktop.

Background:
-----------

b2g-desktop builds for windows do not include a Gaia component i.e. all of the apps including the homescreen. 
In order to get the actual user interface you need to compile the GaiaUI and the build scripts only work on linux/mac
at the moment. This project uses http://nsis.sourceforge.net/ to create an installer that allows windows users
to try out b2g without having to have access to a mac / linux box or have to use a virtual machine.

Update b2g-desktop from nightly:
--------------------------------
If you want to try out a newer b2g-desktop build from http://ftp.mozilla.org/pub/mozilla.org/b2g/nightly/latest-mozilla-central/
extract the download into the b2g-gaia-desktop directory over the existing code.

Update gaia:
------------
Follow the instructions at https://developer.mozilla.org/en/Mozilla/Boot_to_Gecko/Building_and_installing_Boot_to_Gecko
You need only follow the steps for gaia. The build scripts for gaia are currently only available on mac / linux.
The make script will create a profile directory. This directory is cross platform and you can then copy it over the
contents of the gaia directory under b2g-gaia-desktop.

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
