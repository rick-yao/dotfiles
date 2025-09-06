{
  lib,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ~/.gitconfig
  '';

  programs.git = {
    enable = true;

    userName = "Rick Yao";
    userEmail = "abneryaoo@gmail.com";

    ignores = [
      ".DS_Store"
    ];

    includes = [
      {
        # use diffrent email & name for work
        path = "~/work/.gitconfig";
        condition = "gitdir:~/work/";
      }
    ];

    extraConfig = {
      core = {
        editor = "nvim";
      };

      push.default = "current";
      push.autoSetupRemote = true;

      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
      init.defaultBranch = "main";
    };

    # delta = {
    #   enable = true;
    # };
  };
}
