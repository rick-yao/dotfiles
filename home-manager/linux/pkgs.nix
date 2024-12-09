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
    # for ffmpeg hw accel
    intel-media-driver  # for iHD
    intel-vaapi-driver # for i965
    libva
    libva-utils
  ];
}
