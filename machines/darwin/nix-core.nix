{...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-index.enable = true;

  system.stateVersion = 5;
}
