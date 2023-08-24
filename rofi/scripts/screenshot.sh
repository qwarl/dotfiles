#!/bin/bash

# Set the directory where screenshots will be saved
screenshot_dir="$HOME/Pictures/Screenshots"

# Create the directory if it doesn't exist
mkdir -p "$screenshot_dir"

# Get the current date and time
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Function to take a screenshot after a delay and copy to clipboard
delayed_screenshot() {
    sleep 5
    screenshot_file="$screenshot_dir/screenshot_$timestamp.png"
    grim "$screenshot_file"
    wl-copy < "$screenshot_file"
    notify-send "Screenshot Taken" "Screenshot saved and copied to clipboard"
}

# Options menu using rofi
option=$(echo -e "Region\nWindow\nFull Screen\nDelayed 5s" | rofi -dmenu -p "Select screenshot type:")

case "$option" in
    "Region")
        selected_area=$(slurp)
        grim -g "$selected_area" "$screenshot_dir/screenshot_$timestamp.png"
        wl-copy < "$screenshot_dir/screenshot_$timestamp.png"
        notify-send "Screenshot Taken" "Region screenshot saved and copied to clipboard"
        ;;
    "Window")
        focused_window_id=$(swaymsg -t get_tree | grep -o '"id": [0-9]*' | awk '{print $2}')
        focused_rect=$(swaymsg -t get_tree | grep -A 6 "\"id\": $focused_window_id" | grep "rect" | sed 's/[^0-9]*//g')
        grim -g "$focused_rect" "$screenshot_dir/screenshot_$timestamp.png"
        wl-copy < "$screenshot_dir/screenshot_$timestamp.png"
        notify-send "Screenshot Taken" "Window screenshot saved and copied to clipboard"
        ;;
    "Full Screen")
        grim "$screenshot_dir/screenshot_$timestamp.png"
        wl-copy < "$screenshot_dir/screenshot_$timestamp.png"
        notify-send "Screenshot Taken" "Full screen screenshot saved and copied to clipboard"
        ;;
    "Delayed 5s")
        delayed_screenshot
        ;;
esac
