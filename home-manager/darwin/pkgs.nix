{pkgs, ...}: {
  home.packages = with pkgs; [
    skhd
    ffmpeg
  ];
}
