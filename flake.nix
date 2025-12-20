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
    darwinConfigurations."${mkMeta.hostname}" = mkSystem mkMeta.hostname {
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
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://yazi.cachix.org"
      "https://cache.nixos.org"
      "https://cache.lix.systems"
    ];

    trusted-public-keys = [
      "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
    ];

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
