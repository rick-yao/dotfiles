{...}: {
  programs = {
    eza = {
      enable = true;
      enableZshIntegration = false;
    };

    yazi = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
