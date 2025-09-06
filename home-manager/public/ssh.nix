{...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
          serverAliveInterval = 15;
      };
    };
    extraConfig = ''
      Include ~/.config/ssh/sshconfig
    '';
  };
}
