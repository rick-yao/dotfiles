{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
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
		 eval \"$(zoxide init zsh)\"
     eval \"$(fnm env --use-on-cd)\"
		";
    envExtra = "
		 source $HOME/.config/zsh/zshenv-nix
		";
    # oh-my-zsh = {
    #   enable = true;
    #   custom = "$XDG_CONFIG_HOME/omz";
    #   plugins = [
    #     "zoxide"
    #   ];
    #   extraConfig = "
    #      eval \"$(fnm env --use-on-cd)\"
    #   ";
    # };
  };

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = ["--disable-up-arrow"];
  };
}
