## Rick's dotfile

Currently this setup is written by nix and heavily inspired by following repo:

1. [mitchellh/nixos-config](https://github.com/mitchellh/nixos-config)
2. [ryan4yin/nix-darwin-kickstarter](https://github.com/ryan4yin/nix-darwin-kickstarter)
3. [ryan4yin/nixos-and-flakes-book](https://github.com/ryan4yin/nixos-and-flakes-book)

### Platforms

- macOS
- Ubuntu(which I use most, cannot guarantee for other distribution)

### Project Structure

- `flake.nix`: Describes the project and its dependencies (only for flake-enabled projects).
- `home-manager/`: Describes different hm config based on platform.
- `lib/`: Directory for custom Nix functions.
- `machines/`: Directory for custom machine config.
- `overlays/`: Directory for Nix package overlays.
- `config/`: Directory for my custom app config.
