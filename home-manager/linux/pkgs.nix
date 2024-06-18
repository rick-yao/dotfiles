{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    nodePackages_latest.pnpm
    pandoc
    cmake
    nodePackages_latest.wrangler
    # yarn
  ];
}
