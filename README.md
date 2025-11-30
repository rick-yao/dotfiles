# Rick's dotfile

Currently this setup is written by nix flake.

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

- nix -- recommend lix-installer `curl -sSf -L https://install.lix.systems/lix | sh -s -- install`

#### For MacOS

Some deps need installing.
Optional:

- 1password -- I use 1password to sync my ssh keys

#### For Linux

- [Standalone Home manager](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-standalone)
- make --- install via sudo apt-get install make

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

## Inspired By

This project is heavily inspired by following repo:

1. [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config)
2. [ryan4yin/nix-darwin-kickstarter](https://github.com/ryan4yin/nix-darwin-kickstarter)
3. [ryan4yin/nixos-and-flakes-book](https://github.com/ryan4yin/nixos-and-flakes-book)
