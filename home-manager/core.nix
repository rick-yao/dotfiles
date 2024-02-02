{ pkgs, ... }: {
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
    };

    eza = {
      enable = true;
    };

    skim = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}
