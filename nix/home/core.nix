{ pkgs, ... }:

{
  home.packages = with pkgs; [
    zoxide
    ripgrep # recursively searches directories for a regex pattern
    fzf # A command-line fuzzy finder
    yazi
    zsh-autosuggestions
	  git-open
	  zsh-syntax-highlighting
    lazygit
    bat
    btop
    cocoapods
    fastlane
    fd
    smartmontools
    tmux
    wget
  ];

  programs = {
    # modern vim
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    # A modern replacement for ‘ls’
    # useful in bash/zsh prompt, not in nushell.
    eza = {
      enable = true;
    };

    # skim provides a single executable: sk.
    # Basically anywhere you would want to use grep, try sk instead.
    skim = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
