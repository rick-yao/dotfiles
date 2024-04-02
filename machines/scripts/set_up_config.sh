#!/bin/bash

# Define the path to the .config directory
config_dir="$HOME/.config"

# check if link already exists , if exists , do noting , if target is not a link , delete the file or folder then create link
link_file() {
	# The original file you want to link to
	target_file="$1"
	# The symbolic link that you want to create
	link_name="$2"
	
	# First, check if the symlink already exists and points to the correct target
	if [ -L "$link_name" ] && [ "$(realpath "$link_name")" = "$(realpath "$target_file")" ]; then
		# The symbolic link exists and points to the correct target file
		echo "The symbolic link $link_name already points to $target_file."
		return # Exit the function
	fi

	# If the symlink exists but doesn't point to the correct target,
	# or if it doesn't exist but the name is taken by a file or directory, report and remove
	if [ -L "$link_name" ] || [ -e "$link_name" ]; then
		echo "target is not a symbolic link or already exists. Deleting the folder or file."
		rm -rf "$link_name"
	fi

	# Create or update the symbolic link
	ln -sf "$target_file" "$link_name"
	echo "Symbolic link created or updated: $link_name -> $target_file"
}

check_or_create_folder() {
	if [ -d "$1" ]; then
		echo "Folder $1 exists"
	else
		mkdir "$1"
		echo "Folder $1 created"
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

# link astro user and nvim config
link_file "$HOME/dotfiles/config/nvim/AstroNvim" "$config_dir/nvim"

# tmux
link_file "$HOME/dotfiles/config/tmux" "$config_dir/tmux"

# alacritty
link_file "$HOME/dotfiles/config/alacritty" "$config_dir/alacritty"

# ssh
link_file "$HOME/dotfiles/config/ssh" "$config_dir/ssh"

# zsh
link_file "$HOME/dotfiles/config/zsh" "$config_dir/zsh"

# npmrc
link_file "$HOME/dotfiles/config/npm/.npmrc" "$HOME/.npmrc"

# rust
check_or_create_folder "$HOME/.cargo"
link_file "$HOME/dotfiles/config/rust/config" "$HOME/.cargo/config"

# starship
link_file "$HOME/dotfiles/config/starship/starship.toml" "$config_dir/starship.toml"

# dust
link_file "$HOME/dotfiles/config/dust" "$config_dir/dust"

# lsd
link_file "$HOME/dotfiles/config/lsd" "$config_dir/lsd"

# atuin
link_file "$HOME/dotfiles/config/atuin/config.toml" "$config_dir/atuin/config.toml"

# bat
link_file "$HOME/dotfiles/config/bat" "$config_dir/bat"

# kitty
link_file "$HOME/dotfiles/config/kitty" "$config_dir/kitty"
