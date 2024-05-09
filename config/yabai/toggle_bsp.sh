#!/bin/bash

# Get the current layout of the active space
current_layout=$(yabai -m query --spaces --space | jq -r '.type')

# Toggle the layout
if [ "$current_layout" == "bsp" ]; then
    yabai -m space --layout stack
elif [ "$current_layout" == "stack" ]; then
    yabai -m space --layout bsp
else
    echo "Current layout is neither bsp nor stack. Setting to bsp."
    yabai -m space --layout bsp
fi

