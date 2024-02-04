{...}: {
  programs.git = {
    extraConfig = {
      gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
    };

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcijLLEuNPXo3ETb+euCqmvzBlgFOmA092igevTSICB";
      signByDefault = true;
    };
  };
}
