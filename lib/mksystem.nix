{
  nixpkgs,
  overlays,
  inputs,
}: hostName: {
  system,
  user,
  platform,
  nix-homebrew ? null,
}: let
  isLinux = platform == "linux";
  isDarwin = platform == "darwin";

  pkgsConfig = {
    inherit system overlays;
    config.allowUnfree = true;
  };

  pkgs = import nixpkgs pkgsConfig;

  homeManagerConfig = import ../home-manager {
    name = user;
    lib = nixpkgs.lib;
    inherit isLinux isDarwin;
  };

  commonSpecialArgs = {inherit inputs;};

  mkLinuxSystem = inputs.home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = commonSpecialArgs;
    modules = [
      ./configuration.nix
      homeManagerConfig
    ];
  };

  mkDarwinSystem = inputs.darwin.lib.darwinSystem {
    inherit system;
    specialArgs = commonSpecialArgs;
    modules = [
      ./configuration.nix
      ../machines/darwin
      ../machines/${hostName}.nix
      {
        nixpkgs = {
          inherit overlays;
          config.allowUnfree = true;
        };
      }
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          enableRosetta = false;
          user = user;
        };
      }
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = commonSpecialArgs;
        home-manager.users.${user} = homeManagerConfig;
      }
    ];
  };
in
  if isLinux
  then mkLinuxSystem
  else if isDarwin
  then mkDarwinSystem
  else throw "lib/mksystem.nix expects platform to be either \"linux\" or \"darwin\""
