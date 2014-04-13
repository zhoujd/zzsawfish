Compile sawfish with Git
=======


Here the basic installation of Sawfish from GIT in a Debian GNU/Linux Squeeze/Wheezy hybrid from an initial Debian GNU/Linux 6.0.1a installation without a desktop is described.

''Caution'': This is a raw installation into {{Path|/usr/local}} '''without package manager''', and it is '''not''' recommended, if your distribution provides reasonably up-do-date packages or if you're inexperienced. If you proceed, first uninstall the packages coming from your distribution, if you don't do so, you'll very likely run into trouble.

# == Installation ==

## === Getting the Source (GIT) ===

Open a terminal-emulator and create a directory for the Sawfish GIT trees:

    :~$ cd $HOME
    :~$ mkdir build

Go into the build directory and [[Download]] the GIT trees for the build:

    :~$ cd build
    :~/build$ git clone git://git.tuxfamily.org/gitroot/librep/main.git librep
    :~/build$ git clone git://git.tuxfamily.org/gitroot/librep/gtk.git rep-gtk
    :~/build$ git clone git://git.tuxfamily.org/gitroot/sawfish/main.git sawfish
    :~/build$ git clone git://git.tuxfamily.org/gitroot/sawfishpager/pager.git sawfish-pager

## === Dependencies (Debian) ===

Install the tools that you will need to compile the source code. First become root (the system administrator, also: super user). (From now on, distinguish by the prompt-sign if it's necessary to be root) Depending on your setup you might want to use `sudo' instead of `su':

    ~/build$ su
    root@build# aptitude install gettext autoconf libltdl-dev automake \
    libtool autotools-dev gcc libreadline-dev readline-common

This is the point where it is necessary to hybridize the system. The debian way of doing this is through apt-pinning. Open {{Path|/etc/apt/sources.list}} with your favorite editor and add the Wheezy branch of your choosen mirror.

    # debian testing repository
    deb http://debian.uchicago.edu/debian/ wheezy main contrib non-free
    deb-src http://debian.uchicago.edu/debian/ wheezy main contrib non-free

Now use your editor to create or open the file {{Path|/etc/apt/preferences}} and add the following code:

    Package: *
    Pin: release a=squeeze
    Pin-Priority: 900
 
    Package: *
    Pin: release a=wheezy
    Pin-Priority: 10

There are dependencies for Sawfish GIT that must be installed prior to building the Sawfish window manager.

* gtk+ >= 2.24
* pango (optional, but recommended for UTF-8 support)
* gdk-pixbuf-xlib OR imlib1 (imlib2 is currently not supported)

        root@build# aptitude update
        root@build# aptitude install libffi-dev libgdbm-dev \
        libgmp-dev libgtk2.0-dev libpango1.0-0 libgnutls

Become an ordinary user again, by using `exit':

 root@build# exit

## === Building ===

Now we're ready to start building Sawfish. Go into the librep directory, configure, and make:

    :~/build cd librep
    :~/build/librep$ ./configure
    :~/build/librep$ make

If it now fails with an error-message coming from libtool, it's not a bug within Sawfish. Specific versions of libtool 2.6 are known to fail (perhaps http://lists.gnu.org/archive/html/bug-libtool/2011-12/msg00005.html), if that's the case issue autogen instead of configure and proceed with make. If then the issue still appears, you need to check your distributors repo for a different version of libtool 2.6 (older or newer) and start again:

    :~/build$ ./autogen.sh
    :~/build$ make

Install as root.

    :~/build$ su
    root@build/librep# make install
    root@build/librep# exit

Since this will put your installation into /usr/local/ you might have to put it into your path.

    :~/build$ echo $PATH

if the list provided does '''not''' contain /usr/local/bin/ add it using the following command:

    :~/build$ export PATH="$PATH:/usr/local/bin"

http://sawfish.wikia.com/index.php?title=Compilation_from_source&action=edit

Go back to top-level build directory:

    :~/build/librep$ cd ../

The rest of the installation is very similar to the above, thus only commands are listed from this point onward.

'''Remember''': if you had a buggy libtool version, use ./autogen.sh instead of configure.in

    :~/build$ cd rep-gtk
    :~/build/rep-gtk$ ./configure

What to do if librep can't be found? Some distributions don't have the installation directory in the PKG_CONFIG_PATH, therefore librep can't be found. Normally installations in /usr and /usrlocal are fine. If you happen to install somewhere else (say: /opt/), you'll need to do this:

    :~/build/rep-gtk$ export PKG_CONFIG_PATH="$PGK_CONFIG_PATH:/opt/lib/pkgconfig/"

Now continue the build.

    :~/sawfish/rep-gtk$ make

If make fails, giving an error about missing librep library, then that's because your distributor hasn't setup your installation directory properly for building software, fix this by doing:

    root@build/rep-gtk# libtool --finish /usr/local/lib/rep
    root@build/rep-gtk# ldconfig

as root and start make again.

    :~/build/rep-gtk$ make
    root@build/rep-gtk# make install

If you need to run libtool for librep, then repeat that step.

    :~/build/rep-gtk$ cd ../

    :~/build$ cd sawfish
    :~/build/sawfish$ ./configure
    :~/build/sawfish$ make
    root@build/sawfish# make install
    :~/build/sawfish$ cd ../

    :~/build$ cd sawfish-pager
    :~/build/sawfish-pager$ ./configure
    :~/build/sawfish-pager$ make
    root@build/sawfish-pager# make install
    :~/build/sawfish-pager$ cd ../

Install a desktop if you would like one.

## === Installing to a Custom Path ===

When building from GIT you may want to install to a custom location here are the steps to take.

For the purpose of this section '''/opt/sawfish''' will be used as an example.

First set the pkg-config path environment variable.

    export PKG_CONFIG_PATH=/opt/sawfish/lib/pkgconfig

The '''bin''' directory will need to be in the path so the 'rep' command can be found.

    export PATH=$PATH:/opt/sawfish/bin

For building '''librep''', '''rep-gtk''', '''sawfish''' use the prefix argument (this applies to running configure too).

    ./autogen.sh --prefix=/opt/sawfish

''note: the PATH will need to include the custom '''bin''' directory when running sawfish after building.''

## === Apt-Pinning (Debian) ===

Set your apt-pinning so that you do not slowly bleed from a stable sqeeze base to testing (Wheezy). New applications that are installed will come from the wheezy repository. Open the file {{Path|/etc/apt/preferences}} and add the following code:

    Package: *
    Pin: release a=squeeze
    Pin-Priority: 900
 
    Package: *
    Pin: release a=wheezy
    Pin-Priority: -100

Alternately you can hold your distribution in stable by disabling Wheezy in {{Path|/etc/apt/sources.list}} with your favorite editor. Only re-enable the Wheezy repository if aptitude tells you that the package you are trying to install is going to break things.

    # debian testing repository
    # deb http://debian.uchicago.edu/debian/ wheezy main contrib non-free
    # deb-src http://debian.uchicago.edu/debian/ wheezy main contrib non-free

Now explore the Wiki and adjust your newly built Sawfish window manager the way you would like it to be!

