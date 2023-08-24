#!/bin/bash

# Set the directory where screenshots will be saved
screenshot_dir="$HOME/Pictures/Screenshots"

# Create the directory if it doesn't exist
mkdir -p "$screenshot_dir"

# Get the current date and time
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

# Capture a region of the screen using slurp
selected_area=$(slurp)

# Capture the screenshot using grim with the selected area
screenshot_file="$screenshot_dir/screenshot_$timestamp.png"
grim -g "$selected_area" "$screenshot_file"

# Copy the screenshot to the clipboard using wl-copy
wl-copy < "$screenshot_file"

# Display a notification
notify-send "Screenshot Taken" "Region screenshot saved and copied to clipboard: $screenshot_file"
