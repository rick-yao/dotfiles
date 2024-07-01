{pkgs, ...}: {
  home.packages = with pkgs; [
    yazi
    # skhd
    ffmpeg
  ];
}
