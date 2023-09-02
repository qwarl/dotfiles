#!/bin/bash

choices=("  Shutdown" "  Reboot" "  Suspend" "󰍃  Logout" "  Cancel")
chosen=$(printf '%s\n' "${choices[@]}" | rofi -dmenu -i -p "Powermenu" )

case "$chosen" in
    "  Shutdown")
        confirm="Are you sure you want to shutdown?"
        ;;
    "  Reboot")
        confirm="Are you sure you want to reboot?"
        ;;
    "  Suspend")
        confirm="Are you sure you want to suspend?"
        ;;
    "󰍃  Logout")
        confirm="Are you sure you want to logout?"
        ;;
    *)
        exit 0
        ;;
esac

user_confirm=$(echo -e "Yes\nNo" | rofi -dmenu -i -p "$confirm")

if [ "$user_confirm" = "Yes" ]; then
    case "$chosen" in
        "  Shutdown")
            systemctl poweroff
            ;;
        "  Reboot")
            systemctl reboot
            ;;
        "  Suspend")
            systemctl suspend
            ;;
        "󰍃  Logout")
            hyprctl dispatch exit
            ;;
    esac
fi

