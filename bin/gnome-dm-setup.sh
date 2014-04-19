#!/bin/bash

# author: Laurent Orseau - laurent orseau gmail com
# License: WTFPL

# run as root:
# $ sudo bash ./gnome-dm-setup

if [ $EUID -ne 0 ]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

echo "[GNOME Session]
Name=Sawfish/GNOME
RequiredComponents=gnome-settings-daemon;gnome-panel;
RequiredProviders=windowmanager;
DefaultProvider-windowmanager=sawfish
DefaultProvider-notifications=notification-osd
" > /usr/share/gnome-session/sessions/sawfish.session

echo "[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Sawfish
Exec=bash -c 'sawfish&'
NoDisplay=true
X-GNOME-WMName=Sawfish
X-GNOME-Autostart-Phase=WindowManager
X-GNOME-Provides=windowmanager
X-GNOME-Autostart-Notify=false
" > /usr/share/applications/sawfish.desktop

echo "[Desktop Entry]
Name=GNOME with Sawfish
Comment=Gnome with the Sawfish window manager
TryExec=/usr/bin/gnome-session
Exec=gnome-session-sawfish
Type=XSession
" > /usr/share/xsessions/gnome-sawfish.desktop

echo "#! /bin/sh
exec gnome-session --session sawfish \"\$@\"
" > /usr/bin/gnome-session-sawfish

chmod +x /usr/bin/gnome-session-sawfish

echo "Setup complete.
If gnome-panel waits 30s before showing up, 
add the following line around the top of you sawfish rc file:
(system \"(sleep 3 && gnome-panel)&\")"
