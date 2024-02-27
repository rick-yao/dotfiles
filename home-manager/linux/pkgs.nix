{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    nodePackages_latest.pnpm
    pandoc
  ];
}
