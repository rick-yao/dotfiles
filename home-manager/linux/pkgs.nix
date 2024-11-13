{pkgs, ...}: {
  home.packages = with pkgs; [
    ncdu
    yarn
    _1password-cli
    gcc
    pnpm
    pandoc
    cmake
    python312Full
    python312Packages.pip
  ];
}
