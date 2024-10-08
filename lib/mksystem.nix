{
  nixpkgs,
  overlays,
  inputs,
}: name: {
  system,
  user,
  darwin ? false,
  linux ? false,
}: let
  pkgs = nixpkgs.legacyPackages.${system};
  userHMConfig = ../home-manager;

  machineConfig = ../machines/${name}.nix;
  # NixOS vs nix-darwin functionst , if darwin , should be darwinSystem, if linux , should be homeManagerConfiguration because i use hm standalone version in linux
  systemFunc =
    if darwin
    then inputs.darwin.lib.darwinSystem
    else inputs.home-manager.lib.homeManagerConfiguration;
  # HM , if linux , should be empty
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
        # allow unfree pkgs, for example, 1password
        config.allowUnfree = true;
      };

      modules = [
        (import userHMConfig {
          inputs = inputs;
          isLinux = true;
          name = user;
          lib = pkgs.lib;
        })
        ../overlay/rust.nix
      ];

      extraSpecialArgs = {inherit overlays;};
    }
  else if darwin
  then
    systemFunc
    {
      inherit system;

      modules = [
        ../machines/darwin

        machineConfig

        home-manager.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.${user} = import userHMConfig {
            inputs = inputs;
            isDarwin = true;
            name = user;
            lib = pkgs.lib;
          };
        }
        # Rust overlay
        ({pkgs, ...}: {
          nixpkgs.overlays = overlays;
          environment.systemPackages = [
            (pkgs.rust-bin.stable.latest.default.override {
              extensions = ["rust-src"];
            })
          ];
        })
      ];
    }
  else {}
