#!/bin/bash

# Define the path to the .config directory
config_dir="$HOME/.config"

# Check if the .config directory exists
if [ ! -d "$config_dir" ]; then
	# Directory does not exist, so create it
	echo "The .config directory does not exist. Creating it now..."
	mkdir -p "$config_dir"

	if [ $? -eq 0 ]; then
		echo ".config directory created successfully."
	else
		echo "Failed to create .config directory."
		exit 1
	fi
else
	# Directory exists
	echo "The .config directory already exists."
fi

ln -sf "$HOME/dotfiles/kitty" "$config_dir/kitty"

sh ../../nvim/installAstroConfig.sh
ln -sf "$HOME/dotfiles/nvim/AstroNvim" "$config_dir/AstroNvim"
