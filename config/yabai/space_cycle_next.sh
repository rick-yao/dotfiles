#!/bin/bash
info=$(yabai -m query --spaces --display)
last=$(echo "$info" | jq '.[-1]."has-focus"')

if [[ $last == "false" ]]; then
    yabai -m space --focus next
else
    first_space=$(echo "$info" | jq '.[0].index')
    yabai -m space --focus "$first_space"
fi
