{
  nixpkgs,
  overlays,
  inputs,
}: name: {
  system,
  nix-homebrew,
  user,
  darwin ? false,
  linux ? false,
}: let
  pkgs = nixpkgs.legacyPackages.${system};
  userHMConfig = ../home-manager;
  machineConfig = ../machines/${name}.nix;

  systemFunc =
    if darwin
    then inputs.darwin.lib.darwinSystem
    else inputs.home-manager.lib.homeManagerConfiguration;

  home-manager =
    if darwin
    then inputs.home-manager.darwinModules
    else {};
in
  if linux
  then
    systemFunc
    {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        inherit overlays;
      };

      modules = [
        ./configuration.nix

        (import userHMConfig {
          inputs = inputs;
          isLinux = true;
          name = user;
          lib = pkgs.lib;
        })
      ];

      extraSpecialArgs = {inherit inputs;};
    }
  else if darwin
  then
    systemFunc
    {
      inherit system;

      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix

        ../machines/darwin
        machineConfig
        nix-homebrew.darwinModules.nix-homebrew
        {
          nixpkgs.overlays = overlays;
          nix-homebrew = {
            enable = true;
            enableRosetta = false;
            user = user;
          };
        }

        home-manager.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};

          home-manager.users.${user} = import userHMConfig {
            inputs = inputs;
            isDarwin = true;
            name = user;
            lib = pkgs.lib;
          };
        }
      ];
    }
  else {}
