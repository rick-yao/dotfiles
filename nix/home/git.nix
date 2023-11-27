{ config, lib, pkgs, ... }: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig =
    lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
      rm -f ~/.gitconfig
    '';

  programs.git = {
    enable = true;

    # NOTE: replace with your own name & email
    userName = "rick";
    userEmail = "abneryaoo@gmail.com";

    ignores = [
      ".DS_Store"
    ];

    includes = [{
      # use diffrent email & name for work
      path = "~/work/.gitconfig";
      condition = "gitdir:~/work/";
    }];

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      gpg.format = "ssh";
    };

    # signing = {
    #   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDcijLLEuNPXo3ETb+euCqmvzBlgFOmA092igevTSICB";
    #   signByDefault = true;
    # };

    delta = {
      enable = true;
      options = { features = "side-by-side"; };
    };
  };
}
