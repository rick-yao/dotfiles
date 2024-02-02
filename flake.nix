{
  description = "Nix for Rick's Personal Machines";

  outputs =
    inputs @ { self
    , nixpkgs
    , darwin
    , home-manager
    , ...
    }:
    let
      overlays = [
        inputs.rust-overlay.overlays.default
      ];

      mkSystem = import ./lib/mksystem.nix {
        inherit overlays nixpkgs inputs;
      };
    in
    {
      darwinConfigurations."Ricks-MacBook-Air" = mkSystem "Ricks-MacBook-Air" {
        system = "aarch64-darwin";
        user = "rick";
        darwin = true;
      };

      homeConfigurations.rick = mkSystem "build" {
        system = "x86_64-linux";
        user = "rick";
        linux = true;
      };

    };

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];

    auto-optimise-store = true;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay.url = "github:oxalica/rust-overlay";
  };
}
