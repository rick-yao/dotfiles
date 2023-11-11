{ ... }: {
  programs.zsh= {
    enable = true;
    enableCompletion = true;
	package = pkgs.zsh;
  };
}
