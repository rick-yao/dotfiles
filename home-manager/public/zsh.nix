{
  config,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    dotDir = "${config.xdg.configHome}/zsh-nix";
    history = {
      path = "$HOME/.config/zsh-nix/.zsh_history";
      save = 10000;
      size = 10000;
    };

    initContent = "
		 source $HOME/.config/zsh/zshrc-nix
		 eval \"$(zoxide init zsh)\"
     eval \"$(fnm env --use-on-cd)\"
		";
    envExtra = ''
      source $HOME/.config/zsh/zshenv-nix
      ${
        if pkgs.stdenv.isLinux
        then ''
          export LIBVA_DRIVER_NAME="iHD"  # or i965 depending on your GPU
          export LIBVA_DRIVERS_PATH="${pkgs.intel-media-driver}/lib/dri:${pkgs.intel-vaapi-driver}/lib/dri"
        ''
        else ""
      }
    '';
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
