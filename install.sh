#!/bin/sh

echo "install sawfish begin ..."

# setup packages
echo -n "Do you need install packages? (y/N): "
read answer
case "$answer" in
    "Y" | "y" )
        sudo apt-get install -y sawfish sawfish-data sawfish-dbg sawfish-lisp-source sawfish-merlin-ugliness sawfish-themes
	#sudo apt-get install -y sawfish-pager
        sudo apt-get install -y gnome-panel xscreensaver gmrun gcolor2 gcalctool libimlib2 synaptic gconf-editor eog
        sudo apt-get install -y numlockx  imagemagick remmina geany gtkorphan gprename rcconf
        sudo apt-get install -y feh fbpanel gkrellm conky-all
esac

##setup .sawfishrc
ZZSAWFISH_ROOT=`pwd`
cat > ~/.sawfishrc <<EOF
;;;this is .sawfishrc for zhoujd.
(defvar zzsawfish-path "${ZZSAWFISH_ROOT}/")
(load-file (concat zzsawfish-path ".sawfishrc"))
EOF

##git setting
git config user.name "zhoujd"
git config user.email "zjd-405@163.com"

##install conkyrc
rm -f ~/.conkyrc
ln -s ${ZZSAWFISH_ROOT}/misc/.conkyrc ~/.conkyrc

echo "install sawfish end ..."
