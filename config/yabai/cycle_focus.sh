#!/bin/bash

get_next_window_id() {
    # Get all window IDs with split-child not 'none'
    all_ids=($(yabai -m query --windows --space | jq -r '.[] | select(."split-child" != "none") | .id'))
    
    # Get currently focused window's ID
    focused_id=$(yabai -m query --windows --window | jq -r '.id')

    # Find the index of the currently focused window in the allids list, target next
    len=${#all_ids[@]}
    for ((i = 0; i < len; i++)); do
        if [[ "${all_ids[$i]}" == "$focused_id" ]]; then
            next_index=$(( (i + 1) % len ))
            echo "${all_ids[$next_index]}"
            return 0
        fi
    done

    # If current is not found, focus the first in list as a fallback
    if [ $len -gt 0 ]; then
        echo "${all_ids[0]}"
    else
        echo "No suitable window found for focusing."
        return 1
    fi
}

# Get the layout of the current space
layout=$(yabai -m query --spaces --space | jq -r '.type')

if [ "$layout" == "stack" ]; then
    # Obtain the next window ID
    next_window=$(get_next_window_id)

    # Focus the next window in the stack if it exists
    if [ -n "$next_window" ]; then
        yabai -m window --focus "$next_window"
    fi

elif [ "$layout" == "bsp" ]; then
    # Process for BSP layout:
    yabai -m window --focus next || yabai -m window --focus first
else
    echo "Current layout is neither bsp nor stack."
    exit 1
fi
