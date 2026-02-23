{...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.nix-index.enable = true;
  nix.enable = false;

  system.stateVersion = 5;
}
