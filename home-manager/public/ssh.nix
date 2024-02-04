{...}: {
  programs.ssh = {
    enable = true;
    serverAliveInterval = 15;
    extraConfig = ''
      Include ~/.config/ssh/sshconfig
    '';
  };
}
