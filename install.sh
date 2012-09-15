#!/bin/sh

echo "install sawfish begin ..."

# setup packages
echo -n "Do you need install packages? (y/N): "
read answer
case "$answer" in
    "Y" | "y" )
        sudo apt-get install -y sawfish sawfish-data sawfish-dbg sawfish-lisp-source sawfish-merlin-ugliness sawfish-themes sawfish-pager
        sudo apt-get install -y gnome-panel xscreensaver gmrun gcolor2 gcalctool libimlib2 
        sudo apt-get install -y numlockx  imagemagick remmina geany gtkorphan gprename rcconf
        sudo apt-get install -y feh fbpanel gkrellm
esac

##setup .sawfishrc
ZZSAWFISH_ROOT=`pwd`
rm -f ~/.sawfishrc
echo ";;;this is .sawfishrc for zhoujd.">> ~/.sawfishrc
echo "(defvar zzsawfish-path \"${ZZSAWFISH_ROOT}/\")" >> ~/.sawfishrc
echo "(load-file (concat zzsawfish-path \".sawfishrc\"))" >> ~/.sawfishrc

echo "install sawfish end ..."
