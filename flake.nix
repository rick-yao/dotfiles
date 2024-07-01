{
  description = "Nix for Rick's Personal Machines";

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    systems,
    # yazi,
    ...
  }: let
    overlays = [
      inputs.rust-overlay.overlays.default
      # yazi.overlays.default
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };

    mkMeta = import ./lib/mkmeta.nix {};

    eachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    darwinConfigurations."Ricks-MacBook-Air" = mkSystem "Ricks-MacBook-Air" {
      system = "aarch64-darwin";
      user = mkMeta.username;
      darwin = true;
    };

    homeConfigurations."${mkMeta.username}" = mkSystem "build" {
      system = "x86_64-linux";
      user = mkMeta.username;
      linux = true;
    };

    formatter = eachSystem (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    # extra-substituters = [ "https://yazi.cachix.org" ];
    # extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];

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

    # yazi.url = "github:sxyazi/yazi";

    systems.url = "github:nix-systems/default";
  };
}
