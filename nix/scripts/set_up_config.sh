#!/bin/bash

# Define the path to the .config directory
config_dir="$HOME/.config"

link_file() {
	# The original file you want to link to
	target_file="$1"
	# The symbolic link that you want to create
	link_name="$2"

	# Check if the symbolic link already exists and points to the correct target file
	if [ -L "$link_name" ] && [ "$(readlink -f "$link_name")" == "$(readlink -f "$target_file")" ]; then
		# The symbolic link exists and points to the correct target file
		echo "The symbolic link $link_name already points to $target_file."
	else
		# The symbolic link does not exist or points to a different target, so create or update it
		ln -sf "$target_file" "$link_name"
		echo "Symbolic link created or updated: $link_name -> $target_file"
	fi
}

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

link_file "$HOME/dotfiles/kitty" "$config_dir/kitty"
# ln -sf "$HOME/dotfiles/kitty" "$config_dir/kitty"

sh ../../nvim/installAstroConfig.sh
link_file "$HOME/dotfiles/nvim/AstroNvim" "$config_dir/AstroNvim"
# ln -sf "$HOME/dotfiles/nvim/AstroNvim" "$config_dir/AstroNvim"
