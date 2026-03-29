{
  name,
  isLinux ? false,
  isDarwin ? false,
  lib,
  ...
}: let
  # Return every .nix file in a directory in a stable order.
  nixFilesIn = dir:
    lib.sort builtins.lessThan (
      lib.filter (fileName: lib.hasSuffix ".nix" fileName)
      (builtins.attrNames (builtins.readDir dir))
    );

  # Convert ./folder + ["a.nix" "b.nix"] into importable paths.
  modulesFrom = dir: map (fileName: dir + "/${fileName}") (nixFilesIn dir);

  # Shared Home Manager modules loaded on every platform.
  publicModules = modulesFrom ./public;

  # Platform-specific modules are kept separate so it is obvious
  # which files are only meant for Linux or macOS.
  linuxModules = modulesFrom ./linux;

  darwinModules = modulesFrom ./darwin;

  platformModules =
    if isLinux
    then linuxModules
    else if isDarwin
    then darwinModules
    else throw "home-manager/default.nix expects either isLinux or isDarwin to be true";

  homeDirectory =
    if isLinux
    then "/home/${name}"
    else if isDarwin
    then "/Users/${name}"
    else throw "home-manager/default.nix expects either isLinux or isDarwin to be true";
in {
  # Basic Home Manager identity for the current user.
  home = {
    username = name;
    inherit homeDirectory;
    stateVersion = "26.05";
  };

  programs.home-manager.enable = true;

  # Import shared modules first, then the platform-specific overrides.
  imports = publicModules ++ platformModules;
}
