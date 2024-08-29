#!/bin/bash

#ignoreokgs.conf
doas echo "
ignorepkg=sudo
ignorepkg=linux-firmware-nvidia
ignorepkg=linux-firmware-intel
" >> /etc/xbps.d/ignorepkgs.conf

doas echo "
repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-glibc
" >> /etc/xbps.d/hyprland-void.conf

#install all app
doas xbps-install -S $(cat app.lst) $(cat hypr.lst)
doas xbps-remove sudo
doas xbps-remove linux-firmware-nvidia
doas xbps-remove linux-firmware-intel

#doas settings
doas echo "permit persist :wheel" >> /etc/doas.conf

cp -R ../Config/.* ~/

#other settings
doas ln -s /etc/sv/dbus /var/service
doas ln -s /etc/sv/polkitd /var/service
doas ln -s /etc/sv/seatd /var/service
doas ln -s /etc/sv/elogind /var/service

doas ln -s /etc/sv/libvirtd /var/service
doas ln -s /etc/sv/virtlockd /var/service 
doas ln -s /etc/sv/virtlogd /var/service

doas ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime

doas usermod -aG _seatd $USER
doas usermod -aG kvm $USER
doas usermod -aG libvirt $USER
doas usermod -aG wheel $USER

#install fish
chsh

#other settings
sh settings.sh
