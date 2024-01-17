{...}: {
  programs.ssh = {
    enable = true;
    serverAliveInterval = 60;
    extraConfig = ''
      Include ~/.config/ssh/sshconfig
    '';
  };
}
