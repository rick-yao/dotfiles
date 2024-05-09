#!/bin/bash

# Query yabai for information about the current space and windows
windows=($(yabai -m query --windows --space | jq '.[] | select(.minimized == 0) | .id'))

# Check if any windows is in fullscreen
for id in "${windows[@]}"; do
    is_fullscreen=$(yabai -m query --windows --window $id | jq '.zoom-fullscreen')
    if [ "$is_fullscreen" == "1" ]; then
        yabai -m window --toggle zoom-fullscreen
    fi
done

# Toggle fullscreen for each window and move to adjust layout vertically
for (( idx=0; idx<${#windows[@]}; idx++ )); do
    yabai -m window --focus ${windows[$idx]}
    yabai -m window --grid 1:${#windows[@]}:0:$idx:1:1
done

# Optionally reactivate fullscreen
# for id in "${windows[@]}"; do
#     yabai -m window $id --toggle zoom-fullscreen
# done

