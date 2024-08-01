#!/bin/bash

#install theme
cd ~/.icons
tar -xvf icons.tar.gz
rm icons.tar.gz

cd ~/.themes
tar -xvf themes.tar.gz
rm themes.tar.gz

gsettings set org.gnome.desktop.interface icon-theme Flat-Remix-Black-Dark
gsettings set org.gnome.desktop.interface gtk-theme Flat-Remix-GTK-Grey-Dark
gsettings set org.gnome.desktop.interface cursor-theme capitaine-cursors-light
gsettings set org.gnome.desktop.interface font-name 'JetBrainsMono 10'

#other
chmod +x ~/.config/waybar/weather.sh
chmod +x ~/.config/hypr/script/screenshot.sh
chmod +x ~/.config/hypr/script/dontkillsteam.sh
chmod +x ~/.config/hypr/script/grimblast