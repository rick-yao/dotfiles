# This function creates a NixOS system based on our VM setup for a
# particular architecture.
{ nixpkgs, overlays, inputs, ...}:

name:
{
  system,
  user,
  darwin ? false,
  linux ? false,
}:

let
  pkgs = nixpkgs.legacyPackages.${system};
  # The config files for this system.
  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/${user}/${if darwin then "darwin" else "linux" }.nix;
  userHMConfig = ../users/${user}/home-manager.nix;

  # NixOS vs nix-darwin functionst
  systemFunc = if darwin then inputs.darwin.lib.darwinSystem else inputs.home-manager.lib.homeManagerConfiguration;
  home-manager = if darwin then inputs.home-manager.darwinModules else {};
in if linux then systemFunc {

      inherit pkgs;

     # { nixpkgs.overlays = overlays; }
      modules = [
        ../linux/home.nix
         # ../linux/overlays/rust.nix
      ];
      extraSpecialArgs = {inherit overlays;};
  # inherit system;
  #
  # modules = [
  #   # Apply our overlays. Overlays are keyed by system type so we have
  #   # to go through and apply our system type. We do this first so
  #   # the overlays are available globally.
  #   { nixpkgs.overlays = overlays; }
  #
  #   machineConfig
  #   userOSConfig
  #   home-manager.home-manager {
  #     home-manager.useGlobalPkgs = true;
  #     home-manager.useUserPackages = true;
  #     home-manager.users.${user} = import userHMConfig {
  #       isWSL = isWSL;
  #       inputs = inputs;
  #     };
  #   } 
  #
  #   extraSpecialArgs = {inherit rust-overlay};
  #   # We expose some extra arguments so that our modules can parameterize
  #   # better based on these values.
  #   {
  #     config._module.args = {
  #       currentSystem = system;
  #       currentSystemName = name;
  #       currentSystemUser = user;
  #       isWSL = isWSL;
  #       inputs = inputs;
  #     };
  #   }
  # ];
} else {}
