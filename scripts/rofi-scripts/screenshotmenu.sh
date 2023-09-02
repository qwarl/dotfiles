#!/bin/bash

# Set the directory where screenshots will be saved
screenshot_dir="$HOME/Pictures/Screenshots"

# Create the directory if it doesn't exist
mkdir -p "$screenshot_dir"

# Get the current date and time
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# countdown
countdown() {
	for sec in $(seq $1 -1 1); do
		notify-send -h string:x-canonical-private-synchronous:shot-notify -t 1000 -i "$iDIR"/timer.png "Taking shot in : $sec"
		sleep 1
	done
}

# Function to take a screenshot after a delay and copy to clipboard
delayed_screenshot() {
    countdown 5
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
        # focused_window_id=$(swaymsg -t get_tree | grep -o '"id": [0-9]*' | awk '{print $2}')
        # focused_rect=$(swaymsg -t get_tree | grep -A 6 "\"id\": $focused_window_id" | grep "rect" | sed 's/[^0-9]*//g')
        # grim -g "$focused_rect" "$screenshot_dir/screenshot_$timestamp.png"
        # wl-copy < "$screenshot_dir/screenshot_$timestamp.png"
        # notify-send "Screenshot Taken" "Window screenshot saved and copied to clipboard"
        # ;;
        w_pos=$(hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1)
        w_size=$(hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g)
        grim -g "$w_pos $w_size" "$dir/$file"
        notify "Screenshot saved: $dir/$file"
        wl-copy < "$dir/$file"  # Copy to clipboard
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
