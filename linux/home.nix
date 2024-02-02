{...}:
let username = "rick";
in
 {
  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  imports = [../home-manager/zsh.nix ../home-manager/core.nix ../home-manager/git.nix ../home-manager/starship.nix ../home-manager/ssh.nix ../home-manager/pkgs.nix];
}
