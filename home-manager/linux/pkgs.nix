{pkgs, ...}: {
  home.packages = with pkgs; [
    _1password
    gcc
    nodePackages_latest.pnpm
    pandoc
    cmake
    python312Full
    python312Packages.pip
  ];
}
