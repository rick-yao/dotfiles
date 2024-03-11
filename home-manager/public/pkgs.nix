{pkgs, ...}: {
  home.packages = with pkgs; [
    wget
    du-dust
    protobuf
    btop
    gnupg
    nexttrace
    ffmpegthumbnailer
    unar
    poppler
    iperf3
    zoxide
    ripgrep
    fzf
    yazi
    lazygit
    bat
    fd
    smartmontools
    gnused
    lsd
    gitui
    jq
    # go
    lua
    unzip
    deno
    helix
    tmux
    fnm
    onefetch
    cowsay
    deno
    go_1_22
  ];
}
