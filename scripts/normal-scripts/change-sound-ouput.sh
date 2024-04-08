#!/bin/bash

# Get the current default sink
current_sink="$(pactl info | awk -F ': ' '/^Default Sink: /{print $2}')"

# Get a list of available sinks
available_sinks=($(pactl list sinks short | awk '{print $2}'))

# Find the index of the current sink in the list
for i in "${!available_sinks[@]}"; do
    if [[ "${available_sinks[$i]}" == "$current_sink" ]]; then
        current_sink_index="$i"
        break
    fi
done

# Calculate the index of the next sink
next_sink_index=$(( (current_sink_index + 1) % ${#available_sinks[@]} ))

# Get the name of the next sink
next_sink="${available_sinks[$next_sink_index]}"

# Change the default sink to the next sink
pactl set-default-sink "$next_sink"

echo "Switched audio output to $next_sink."

