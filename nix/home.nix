{ ... }:
let
  username = "rick";
in
{
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  imports = [ ../home-manager ];
}
