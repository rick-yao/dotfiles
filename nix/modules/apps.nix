{ pkgs, ... }: {

  ##########################################################################
  # 
  #  Install all apps and packages here.
  #
  #  NOTE: Your can find all available options in:
  #    https://daiderd.com/nix-darwin/manual/index.html
  #
  ##########################################################################

  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  environment.systemPackages = with pkgs; [ neovim git ];
  environment.variables.EDITOR = "nvim";

  # Homebrew Mirror in China
  # Feel free to remove this if you are not in China.
  environment.variables = {
    HOMEBREW_API_DOMAIN =
      "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN =
      "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE =
      "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE =
      "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
  };

  # NOTE: To make this work, homebrew need to be installed manually, see https://brew.sh
  # 
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas 
    # masApps = {
      # NOTE: Feel free to add your favorite apps here. https://github.com/mas-cli/mas to check the app id.
      # Wechat = 836500024;
      # QQ = 451108668;
    # };

    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
    ];

    # `brew install`
    # NOTE: Feel free to add your favorite apps here.
    brews = [
      "wget" # download tool
    ];

    # `brew install --cask`
    # NOTE: Feel free to add your favorite apps here.
    casks = [
      "firefox"
      # "google-chrome"
      # "visual-studio-code"
      "iina" 
      "kitty"
    ];
  };
}
