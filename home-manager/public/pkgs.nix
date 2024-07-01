{pkgs, ...}: {
  home.packages = with pkgs; [
    nix-prefetch-git
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
    delta
    curlie
    rust-analyzer
    gh
    http-server
    hyfetch
    zellij
  ];
}
