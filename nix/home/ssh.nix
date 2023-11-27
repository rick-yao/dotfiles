
{ ... }: {
 programs.ssh = {
    enable = true;
    extraConfig = ''
      Include $HOME/.config/ssh/sshconfig
    '';
 }
}
