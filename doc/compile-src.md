Compile Sawfish for source
========

<http://sawfish.wikia.com/wiki/Compilation_from_source>

Here the basic installation of Sawfish 1.8.1 under Debian GNU/Linux 6.0.1a (Squeeze) is described, but it's almost the same for practically every GNU/Linux. *BSD, Solaris or other Unixoids might require additional steps.
 
Caution: This is a raw installation into /usr/local without package manager, and it is not recommended, if your distribution provides reasonably up-do-date packages or if you're inexperienced. If you proceed, first uninstall the packages coming from your distribution, if you don't do so, you'll very likely run into trouble.
 
# Installation
 
Open a terminal-emulator and create a directory for the Sawfish source files: 

    :~$ cd $HOME
    :~$ mkdir build
 
Go into the build directory and Download the source files for the build: 

    :~$ cd build
    :~/build$ wget http://download.tuxfamily.org/librep/librep-0.92.0.tar.bz2
    :~/build$ wget http://download.tuxfamily.org/librep/rep-gtk/rep-gtk-0.90.6.tar.bz2
    :~/build$ wget http://download.tuxfamily.org/sawfish/sawfish-1.8.1.tar.bz2
    :~/build$ wget http://download.tuxfamily.org/sawfishpager/sawfish-pager-0.90.2.tar.bz2
 
Extract the code from the .tar.bz2 (alternatively you can grab .tar.xz files) files.

    :~/build$ tar -xvjf librep-0.92.0.tar.bz2
    :~/build$ tar -xvjf rep-gtk-0.90.6.tar.bz2
    :~/build$ tar -xvjf sawfish-1.8.1.tar.bz2
    :~/build$ tar -xvjf sawfish-pager-0.90.2.tar.bz2
 
For GNU/Tar atleast `tar xf file.tar.bz2' is enough. 

There are dependencies for Sawfish 1.8.1 that must be installed prior to building the Sawfish window manager.
■ gtk+ >= 2.12 
■ pango (optional, but recommended for UTF-8 support) 
■ gdk-pixbuf-xlib OR imlib1 (imlib2 is currently not supported) 
■ GNU autotools to compile. 

First become root (the system administrator, also: super user). (From now on, distinguish by the prompt-sign if it's necessary to be root). Depending on your setup, you might want to use `sudo' instead of `su'.

    ~/build$ su
    root@build# aptitude install gettext autoconf libltdl-dev automake \
    libtool autotools-dev gcc libreadline-dev readline-common libffi-dev \
    libgdbm-dev libgmp3-dev libgmp3-doc libgtk2.0-doc libgtk2.0-dev \
    libpango1.0-dev libpango1.0-doc lsb-build-desktop3
 
On Linux-Mint 12 (and probably Ubuntu 11.10) the following packages were also required:

    root@build# aptitude install libgdbm-dev texinfo libxtst-dev
 
Become an ordinary user again, by using `exit': 

    root@build# exit
 
On other GNU/Linux' you'll use the package manager provided (eg: yum for Fedora, zypper for SuSE).
 
Now we're ready to start building Sawfish. Go into the librep directory, configure, and make:

    :~/build cd librep-0.92.0
    :~/build/librep-0.92.0$ ./configure
    :~/build/librep-0.92.0$ make
 
If it now fails with an error-message coming from libtool, it's not a bug within Sawfish. Specific versions of libtool 2.6 are known to fail, if that's the case issue autogen instead of configure and proceed with make. If then the issue still appears, you need to check your distributors repo for a different version of libtool 2.6 (older or newer) and start again:

    :~/build$ ./autogen.sh
    :~/build$ make
 
Install as root: 

    :~/build$ su
    root@build/librep-0.92.0# make install
    root@build/librep-0.92.0# exit
 
Since this will put your installation into /usr/local/ you might have to put it into your path.

    :~/build$ echo $PATH
 
if the list provided does not contain /usr/local/bin/ add it using the following command:

    :~/build$ export PATH="$PATH:/usr/local/bin"
 
additionally add this line at the end of your shell's configuration file, for GNU Bash it would be $HOME/.bashrc
 
Go back to top-level build directory: 

    :~/build/librep-0.92.0$ cd ../
 
The rest of the installation is very similar to the above, thus only commands are listed from this point onward.
 
Remember: if you had a buggy libtool version, use ./autogen.sh instead of configure.in

    :~/build$ cd rep-gtk-0.90.6
    :~/build/rep-gtk-0.90.6$ ./configure
 
What to do if librep can't be found? Some distributions don't have the
installation directory in the **PKG_CONFIG_PATH**, therefore librep can't be
found. Normally installations in /usr and /usr/local are fine. If you happen to
install somewhere else (say: /opt/), you'll need to do this:

    :~/build/rep-gtk-0.90.6$ export PKG_CONFIG_PATH="$PGK_CONFIG_PATH:/opt/lib/pkgconfig/"
 
Now continue the build. 

    :~/sawfish/rep-gtk-0.90.6$ make
 
If make fails, giving an error about missing librep library, then that's because your distributor hasn't setup your installation directory properly for building software, fix this by doing:

    root@build/rep-gtk-0.90.6# libtool --finish /usr/local/lib/rep
    root@build/rep-gtk-0.90.6# ldconfig
 
as root and start make again. Sometimes it might be sufficient to simply update the shared library ld cache using the "ldconfig" command.

    ;~/build/rep-gtk-0.90.6$ make
    root@build/rep-gtk-0.90.6# make install
 
If you needed to run libtool for librep, then repeat that step for rep-gtk. 

    :~/build/rep-gtk-0.90.6$ cd ../
    :~/build$ cd sawfish-1.8.1
    :~/build/sawfish-1.8.1$ ./configure
    :~/build/sawfish-1.8.1$ make
    root@build/sawfish-1.8.1# make install
    :~/build/sawfish-1.8.1$ cd ../
    :~/build$ cd sawfish-pager-0.90.2
    :~/build/sawfish-pager-0.90.2$ ./configure
    :~/build/sawfish-pager-0.90.2$ make
    root@build/sawfish-pager-0.90.2# make install
    :~/build/sawfish-pager-0.90.2$ cd $HOME
 
Now explore the Wiki and adjust your newly build Sawfish window manager the way you would like it to be!
 
