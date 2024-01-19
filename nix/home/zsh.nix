{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    dotDir = ".config/zsh-nix";
    historySubstringSearch.enable = true;
    history = {
    path = "$ZDOTDIR/.zsh_history";
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
      plugins = ["zoxide"];
    };

    # dotDir = ".config/zsh";
    # envExtra = "export AAA = "~/.config/xxx"";
  };
}
