{...}: {
  programs.git = {
    extraConfig = {
      gpg.ssh.program = "gpg2";
    };
  };
}
