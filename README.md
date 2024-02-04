# Rick's dotfile

Currently this setup is written by nix and heavily inspired by following repo:

1. [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config)
2. [ryan4yin/nix-darwin-kickstarter](https://github.com/ryan4yin/nix-darwin-kickstarter)
3. [ryan4yin/nixos-and-flakes-book](https://github.com/ryan4yin/nixos-and-flakes-book)

## Platforms

- macOS
- Ubuntu(which I use most, cannot guarantee for other distribution)

## Project Structure

- `flake.nix`: Describes the project and its dependencies (only for flake-enabled projects).
- `home-manager/`: Describes different hm config based on platform.
- `lib/`: Directory for custom Nix functions.
- `machines/`: Directory for custom machine config.
- `overlays/`: Directory for Nix package overlays.
- `config/`: Directory for my custom app config.

## How to use

### Platform Prerequisite

#### For MacOS

Some deps need installing.

- nix -- recommend [nix-installer](https://github.com/DeterminateSystems/nix-installer)

- [Homebrew](https://brew.sh/)

Optional:

- 1password -- I use 1password to sync my ssh keys

#### For Linux

- [Standalone Home manager](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone)

### Deploy

#### MacOS

1. Update the hostname of your mac
2. execute command

```bash
make deploy-mac
```

3. Logout and login to make setting take effect

#### Linux

1. execute command

```bash
home-manager switch --flake /your/dotfiles/path
```
