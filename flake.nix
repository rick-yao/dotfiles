{
  description = "Nix for Rick's Personal Machines";

  outputs = inputs @ {
    nixpkgs,
    systems,
    yazi,
    nix-homebrew,
    ...
  }: let
    overlays = [
      yazi.overlays.default
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
      nix-homebrew = nix-homebrew;
    };

    homeConfigurations."${mkMeta.username}" = mkSystem "build" {
      system = "x86_64-linux";
      user = mkMeta.username;
      linux = true;
      nix-homebrew = nix-homebrew;
    };

    formatter = eachSystem (system: nixpkgs.legacyPackages.${system}.alejandra);
  };

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];

    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://yazi.cachix.org"
      "https://cache.nixos.org"
    ];

    extra-trusted-public-keys = ["yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="];

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

    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";

    systems.url = "github:nix-systems/default";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };
}
