{pkgs, ...}: {
  home.packages = with pkgs; [
    # yazi
    gcc
    nodePackages_latest.pnpm
    pandoc
    cmake
    python3
    # nodePackages_latest.wrangler
    # yarn
  ];
}
