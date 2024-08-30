{pkgs, ...}: {
  home.packages = with pkgs; [
    yarn
    _1password
    gcc
    pnpm
    pandoc
    cmake
    python312Full
    python312Packages.pip
  ];
}
