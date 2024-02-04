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
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  imports =
    (importsFromFolder ./public)
    ++ lib.optionals isLinux (importsFromFolder ./linux)
    ++ lib.optionals isDarwin (importsFromFolder ./darwin);
}
