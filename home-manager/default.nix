# home manager conf, shared between all platforms
# parameters:
#   - name: the user name
#   - lib: the nixpkgs lib
#   - isLinux: true if the system is linux
#   - isDarwin: true if the system is darwin
# this will load the configuration from the public folder and the platform specific folder
{
  isLinux ? false,
  name,
  lib,
  isDarwin ? false,
  ...
}: let
  nixFilesInFolder = folder:
    lib.filter (fileName: lib.hasSuffix ".nix" fileName) (builtins.attrNames (builtins.readDir folder));

  importsFromFolder = folder:
    map (fileName: import (folder + "/${fileName}")) (nixFilesInFolder folder);
in {
  home = {
    username = name;
    homeDirectory =
      if isLinux
      then "/home/${name}"
      else "/Users/${name}";
    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;

  imports =
    (importsFromFolder ./public)
    ++ lib.optionals isLinux (importsFromFolder ./linux)
    ++ lib.optionals isDarwin (importsFromFolder ./darwin);
}
