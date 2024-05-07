import os
import shutil
from pathlib import Path

# Define the path to the .config directory
config_dir = f"{Path.home()}/.config"


def link_file(target_file, link_name):
    # The original file you want to link to
    target_file = Path(target_file)
    # The symbolic link that you want to create
    link_name = Path(link_name)

    # First, check if the symlink already exists and points to the correct target
    if link_name.is_symlink() and os.path.realpath(link_name) == os.path.realpath(
        target_file
    ):
        # The symbolic link exists and points to the correct target file
        print(f"The symbolic link {link_name} already points to {target_file}.")
        return  # Exit the function

    # If the symlink exists but doesn't point to the correct target,
    # or if it doesn't exist but the name is taken by a file or directory, report and remove
    if link_name.exists():
        print(
            f"Target is not a symbolic link or already exists. Deleting the folder or file: {link_name}"
        )
        if link_name.is_symlink():
            link_name.unlink()
        else:
            shutil.rmtree(link_name)

    # Create or update the symbolic link
    link_name.parent.mkdir(parents=True, exist_ok=True)
    link_name.symlink_to(target_file)
    print(f"Symbolic link created or updated: {link_name} -> {target_file}")


def check_or_create_folder(folder_path):
    folder_path = Path(folder_path)
    if folder_path.exists():
        print(f"Folder {folder_path} exists")
    else:
        folder_path.mkdir(parents=True)
        print(f"Folder {folder_path} created")


# Check if the .config directory exists
config_dir_path = Path(config_dir)
if not config_dir_path.exists():
    # Directory does not exist, so create it
    print("The .config directory does not exist. Creating it now...")
    config_dir_path.mkdir(parents=True)
    print(".config directory created successfully.")
else:
    # Directory exists
    print("The .config directory already exists.")

# link astro user and nvim config
link_file(f"{Path.home()}/dotfiles/config/nvim/astro", f"{config_dir}/nvim")

# tmux
link_file(f"{Path.home()}/dotfiles/config/tmux", f"{config_dir}/tmux")

# alacritty
link_file(f"{Path.home()}/dotfiles/config/alacritty", f"{config_dir}/alacritty")

# ssh
link_file(f"{Path.home()}/dotfiles/config/ssh", f"{config_dir}/ssh")

# zsh
link_file(f"{Path.home()}/dotfiles/config/zsh", f"{config_dir}/zsh")

# npmrc
link_file(f"{Path.home()}/dotfiles/config/npm/.npmrc", f"{Path.home()}/.npmrc")

# rust
rust_cargo_dir = Path.home() / ".cargo"
check_or_create_folder(rust_cargo_dir)
link_file(f"{Path.home()}/dotfiles/config/rust/config", f"{rust_cargo_dir}/config")

# starship
link_file(
    f"{Path.home()}/dotfiles/config/starship/starship.toml",
    f"{config_dir}/starship.toml",
)

# dust
link_file(f"{Path.home()}/dotfiles/config/dust", f"{config_dir}/dust")

# lsd
link_file(f"{Path.home()}/dotfiles/config/lsd", f"{config_dir}/lsd")

# atuin
atuin_config_dir = config_dir_path / "atuin"
check_or_create_folder(atuin_config_dir)
link_file(
    f"{Path.home()}/dotfiles/config/atuin/config.toml",
    f"{atuin_config_dir}/config.toml",
)

# bat
link_file(f"{Path.home()}/dotfiles/config/bat", f"{config_dir}/bat")

# kitty
link_file(f"{Path.home()}/dotfiles/config/kitty", f"{config_dir}/kitty")

# my scripts
link_file(f"{Path.home()}/dotfiles/config/my_scripts", f"{config_dir}/my_scripts")
