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

The `Makefile` will automatically detect your current username and hostname.

**Standard Deployment:**

```bash
make deploy-mac
```

**Custom Deployment:**
You can override the target user or host if needed:

```bash
# Deploy for a different user
make deploy-mac USER=alice

# Deploy for a specific host (requires machines/<Host>.nix)
make deploy-mac HOST=OfficeMac
```

**Note:** You may need to logout and login for some settings to take full effect.

#### Linux

```bash
make deploy-linux
```

## Inspired By

This project is heavily inspired by following repo:

1. [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config)
2. [ryan4yin/nix-darwin-kickstarter](https://github.com/ryan4yin/nix-darwin-kickstarter)
3. [ryan4yin/nixos-and-flakes-book](https://github.com/ryan4yin/nixos-and-flakes-book)
