{pkgs, ...}: {
  # Install packages from nix's official package repository.
  #
  # The packages installed here are available to all users, and are reproducible across machines, and are rollbackable.
  # But on macOS, it's less stable than homebrew.
  #
  # Related Discussion: https://discourse.nixos.org/t/darwin-again/29331
  # environment.systemPackages = with pkgs; [nixpkgs-fmt];
  environment.variables.EDITOR = "nvim";

  # Homebrew Mirror in China
  environment.variables = {
    HOMEBREW_API_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
    HOMEBREW_PIP_INDEX_URL = "https://pypi.tuna.tsinghua.edu.cn/simple";
  };

  # NOTE: To make this work, homebrew need to be installed manually, see https://brew.sh
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      # 'zap': uninstalls all formulae(and related files) not listed here.
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    masApps = {
      # NOTE: use https://github.com/mas-cli/mas to check the app id.
      Wechat = 836500024;
      TailScale = 1475387142;
      Mindnode = 1289197285;
      # CommandX = 2141473041;
      Amphetamine = 937984704;
      QQ = 451108668;
      Telegram = 747648890;
      Copyless = 993841014;
      RDP = 1295203466;
      Xcode-Cleaner = 1296084683;
      Tick-Tick = 966085870;
      Run-Cat = 1429033973;
      Server-Cat = 1501532023;
      # Wecom = 1189898970;
    };

    taps = [
      "homebrew/services"
      "1password/tap"
      "koekeishiya/formulae"
      "oven-sh/bun"
    ];

    # `brew install`
    brews = [
      "pnpm"
      "telnet"
      "cocoapods"
      "fastlane"
      "yarn"
      "mas"
      "gnu-sed"
      "luarocks"
      "ollama"
      "bun"
    ];

    # `brew install --cask`
    casks = [
      "jordanbaird-ice"
      "firefox"
      "1password-cli"
      "google-chrome"
      "google-chrome@dev"
      "visual-studio-code"
      "iina"
      "kitty"
      "amethyst"
      "syntax-highlight"
      "zulu@11"
      "alacritty"
      "font-symbols-only-nerd-font"
      "alt-tab"
      "appcleaner"
      "coteditor"
      "cyberduck"
      "fork"
      "input-source-pro"
      "keka"
      "mos"
      "netnewswire"
      "obsidian"
      "spotify"
      "sublime-text"
      "syntax-highlight"
      "snipaste"
      # "logi-options-plus"
      "font-monaspace"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "font-fira-code"
      "microsoft-edge"
      "macupdater"
      "zed"
      "font-cascadia-code"
      "stats"
      "raycast"
      "skim"
      "loop"
    ];
  };
}
