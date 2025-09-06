{...}  :
#############################################################
#
#  Host & Users configuration
#
#############################################################
let
  # NOTE: change this to your hostname
  hostname = "Ricks-MacBook-Air";
  mkMeta = import ../../lib/mkmeta.nix {};
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
