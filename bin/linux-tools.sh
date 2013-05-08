#!/bin/sh

##video player
sudo apt-get remove totem*
sudo apt-get install vlc

sudo apt-get install samba
sudo apt-get install system-config-samba

##deb install graphic tools
sudo apt-get install gdebi

##Gnome 2.x
sudo apt-get install gnome-shell
sudo apt-get install gnome-shell-extensions
sudo apt-get install gnome-tweak-tool
sudo apt-get install nautilus-open-terminal

##Ubuntu Tweak
#sudo add-apt-repository ppa:tualatrix/ppa
#sudo apt-get update
#sudo apt-get install ubuntu-tweak

##myunity
#sudo apt-get install myunity

##flash player plugin
sudo apt-get install flashplugin-installer

##input methold
#sudo apt-get install ibus-googlepinyin
#sudo apt-get install ibus-sunpinyin

sudo add-apt-repository ppa:fcitx-team/nightly
sudo apt-get update
sudo apt-get install fcitx
sudo apt-get install fcitx-googlepinyin
sudo apt-get install fcitx-sunpinyin
sudo apt-get install fcitx-module-cloudpinyin

