{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    dotDir = ".config/zsh-nix";
    history = {
      path = "$HOME/.config/zsh-nix/.zsh_history";
      save = 10000;
      size = 10000;
    };

    initExtra = "
		 source $HOME/.config/zsh/zshrc-nix
		";
    envExtra = "
		 source $HOME/.config/zsh/zshenv-nix
		";
    oh-my-zsh = {
      enable = true;
      custom = "$XDG_CONFIG_HOME/omz";
      plugins = [
        "zoxide"
        "zsh-nvm"
      ];
      extraConfig = "
      export NVM_COMPLETION=false
      export NVM_LAZY_LOAD=true
      export NVM_LAZY_LOAD_EXTRA_COMMANDS=(vim nvim pnpm yarn)
      ";
    };

    # dotDir = ".config/zsh";
    # envExtra = "export AAA = "~/.config/xxx"";
  };
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = ["--disable-up-arrow"];
  };
}
