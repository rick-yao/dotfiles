{...}:
#############################################################
#
#  Host & Users configuration
#
#############################################################
let
  # usage: import from flake in the future?
  mkMeta = import ../../lib/mkmeta.nix {};
  hostname = mkMeta.hostname;
  username = mkMeta.username;
in {
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  nix.settings.trusted-users = [username];
}
