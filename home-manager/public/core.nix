{ ...}: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = false;
    };

    # skim = {
    #   enable = true;
    #   enableZshIntegration = true;
    # };

    yazi = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
