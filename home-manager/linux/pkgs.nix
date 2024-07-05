{pkgs, ...}: {
  home.packages = with pkgs; [
    # yazi
    gcc
    nodePackages_latest.pnpm
    pandoc
    cmake
    # nodePackages_latest.wrangler
    # yarn
  ];
}
