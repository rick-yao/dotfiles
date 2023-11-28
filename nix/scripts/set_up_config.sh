#!/bin/bash

# Define the path to the .config directory
config_dir="$HOME/.config"

# check if link already exists , if exists , do noting , if not create link
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

# this shell copys custom user config to astro user dir
if [ -L "$HOME/dotfiles/nvim/AstroNvim/lua/user" ]; then
  echo "astro user is a symbolic link."
else
  echo "astro user is not a symbolic link. Delete the folder."
  rm -rf $HOME/dotfiles/nvim/AstroNvim/lua/user/
fi
link_file "$HOME/dotfiles/nvim/astro-personal-config" "$HOME/dotfiles/nvim/AstroNvim/lua/user"
link_file "$HOME/dotfiles/nvim/AstroNvim" "$config_dir/nvim"

link_file "$HOME/dotfiles/alacritty" "$config_dir/alacritty"

link_file "$HOME/dotfiles/tmux" "$config_dir/tmux"

link_file "$HOME/dotfiles/ssh" "$config_dir/ssh"
