{...}: {
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Include ~/.config/ssh/sshconfig
    '';
  };
}
