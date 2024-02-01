{
  description = "Home Manager configuration of rick";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      username = "rick";
    in {
      homeConfigurations.username = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ../home-manager ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}

