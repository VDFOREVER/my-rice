#!/bin/bash

#ignoreokgs.conf
echo "
ignorepkg=sudo
ignorepkg=linux-firmware-nvidia
ignorepkg=linux-firmware-intel
" >> /etc/xbps.d/ignorepkgs.conf

echo "
repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-glibc
" >> /etc/xbps.d/hyprland-void.conf

#install all app
xbps-install -S $(cat app.lst) $(cat hypr.lst)
xbps-remove sudo
xbps-remove linux-firmware-nvidia
xbps-remove linux-firmware-intel

cp -R ../Config/.* ~/

#doas settings
echo "permit persist :wheel" >> /etc/doas.conf

#other settings
ln -s /etc/sv/dbus /var/service
ln -s /etc/sv/polkitd /var/service
ln -s /etc/sv/seatd /var/service
ln -s /etc/sv/elogind /var/service
ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

doas usermod -aG _seatd $USER
doas usermod -aG kvm $USER
doas usermod -aG libvirt $USER
doas usermod -aG wheel $USER

#install fish
chsh

#other settings
sh settings.sh
