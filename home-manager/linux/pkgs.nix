{pkgs, ...}: {
  home.packages = with pkgs; [
    # yazi
    gcc
    nodePackages_latest.pnpm
    pandoc
    cmake
    python312Full
    python312Packages.pip
    # nodePackages_latest.wrangler
    # yarn
  ];
}
