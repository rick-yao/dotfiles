{...}: {
  programs.git = {
    extraConfig = {
      gpg.format = "ssh";
    };

    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
  };
}
