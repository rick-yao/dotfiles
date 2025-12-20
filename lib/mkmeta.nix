{}: let
  username = builtins.getEnv "NIX_USERNAME";
  hostname = builtins.getEnv "NIX_HOSTNAME";
in {
  username =
    if username == ""
    then "rick"
    else username;
  hostname =
    if hostname == ""
    then "Ricks-MacBook-Air"
    else hostname;
}
