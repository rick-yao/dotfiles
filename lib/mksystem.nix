{
  nixpkgs,
  overlays,
  inputs,
}: name: {
  system,
  user,
  darwin ? false,
  linux ? false,
  nix-homebrew ? null,
}: let
  # Common configuration for nixpkgs
  nixpkgsConfig = {
    inherit system overlays;
    config.allowUnfree = true;
  };

  # Linux / Home Manager Configuration
  linuxSystem = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = import nixpkgs nixpkgsConfig;
    extraSpecialArgs = {inherit inputs;};
    modules = [
      ./configuration.nix
      (import ../home-manager {
        inherit inputs;
        isLinux = true;
        name = user;
        lib = nixpkgs.lib;
      })
    ];
  };

  # Darwin Configuration
  darwinSystem = inputs.darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {inherit inputs;};
    modules = [
      ./configuration.nix
      ../machines/darwin
      ../machines/${name}.nix

      # Nixpkgs configuration for Darwin
      {
        nixpkgs = {
          inherit overlays;
          config.allowUnfree = true;
        };
      }

      # Nix-Homebrew configuration
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          enableRosetta = false;
          user = user;
        };
      }

      # Home Manager configuration for Darwin
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit inputs;};
        home-manager.users.${user} = import ../home-manager {
          inherit inputs;
          isDarwin = true;
          name = user;
          lib = nixpkgs.lib;
        };
      }
    ];
  };
in
  if linux
  then linuxSystem
  else if darwin
  then darwinSystem
  else throw "System must be strictly either 'linux' or 'darwin'"
