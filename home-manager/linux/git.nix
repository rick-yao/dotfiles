{...}: {
  programs.git = {
    extraConfig = {
      gpg.ssh.program = "/home/rick/.nix-profile/bin/gpg2";
    };

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcijLLEuNPXo3ETb+euCqmvzBlgFOmA092igevTSICB";
      signByDefault = true;
    };
  };
}
