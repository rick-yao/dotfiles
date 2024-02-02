{ pkgs,... }: {
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
    # gcc
    go
    lua
    unzip
    pre-commit
  ];
}
