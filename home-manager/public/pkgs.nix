{pkgs, ...}: {
  home.packages = with pkgs; [
    xh
    htop
    procs
    lazydocker
    fastfetch
    # tailspin
    wget
    du-dust
    protobuf
    btop
    gnupg
    ffmpegthumbnailer
    unar
    poppler
    iperf3
    zoxide
    ripgrep
    lazygit
    bat
    fd
    smartmontools
    gnused
    lsd
    gitui
    jq
    # go
    lua54Packages.lua
    unzip
    deno
    helix
    tmux
    fnm
    onefetch
    cowsay
    deno
    go_1_22
    hyperfine
    gping
    procs
    doggo
    duf
    # delta
    curlie
    rust-analyzer
    gh
    http-server
    hyfetch
    zellij
    p7zip
    chafa
    imagemagick
  ];
}
