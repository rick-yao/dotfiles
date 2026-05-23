{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        serverAliveInterval = 15;
      };
    };
    extraConfig = ''
      Include ~/.config/ssh/sshconfig
    '';
  };
}
