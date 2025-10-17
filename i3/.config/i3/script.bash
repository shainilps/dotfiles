#!/bin/bash

choice=$(echo -e "Lock\nLogout\nReboot\nShutdown\nCancel" | rofi -dmenu -p "i3exit")

case "$choice" in
Lock)
    i3lock
    ;;
Logout)
    i3-msg exit
    ;;
Reboot)
    systemctl reboot
    ;;
Shutdown)
    systemctl poweroff
    ;;
Cancel)
    exit 0
    ;;
esac
