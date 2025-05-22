{pkgs, ...}:
###################################################################################
#
#  macOS's System configuration
#
#  All the configuration options are documented here:
#    https://daiderd.com/nix-darwin/manual/index.html#sec-options
#  and see the source code of this project to get more undocumented options:
#    https://github.com/rgcr/m-cli
#
###################################################################################
let 
  mkMeta = import ../lib/mkmeta.nix {};
  username = mkMeta.username;
in 
{
  system = {

    primaryUser = username;
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    # NOTE: not working on macOS 14
    # activationScripts.postUserActivation.text = ''
    #   # activateSettings -u will reload the settings from the database and apply them to the current session,
    #   # so we do not need to logout and login again to make the changes take effect.
    #   echo "reload start..."
    #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    # '';

    defaults = {
      # dock
      dock = {
        autohide = true;
        show-recents = false; # disable recent apps
        # customize Hot Corners
        wvous-bl-corner = 5; # bottom-left
      };

      # finder
      finder = {
        _FXShowPosixPathInTitle = true; # show full path in finder title
        AppleShowAllExtensions = true; # show all file extensions
        FXEnableExtensionChangeWarning = false; # disable warning when changing file extension
        ShowPathbar = true; # show path bar
      };

      # macOS
      NSGlobalDomain = {
        # `defaults read NSGlobalDomain "xxx"`
        "com.apple.swipescrolldirection" =
          true; # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" =
          0; # disable beep sound when pressing volume up/down key
        AppleInterfaceStyleSwitchesAutomatically = true; # auto switch dark mode
        ApplePressAndHoldEnabled = false; # enable press and hold

        # If you press and hold certain keyboard keys when in a text area, the key’s character begins to repeat.
        # This is very useful for vim users, they use `hjkl` to move cursor.
        # sets how long it takes before it starts repeating.
        InitialKeyRepeat =
          15; # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts.
        KeyRepeat = 2; # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        NSAutomaticCapitalizationEnabled =
          false; # disable auto capitalization
        NSAutomaticDashSubstitutionEnabled =
          false; # disable auto dash substitution
        NSAutomaticPeriodSubstitutionEnabled =
          false; # disable auto period substitution
        NSAutomaticQuoteSubstitutionEnabled =
          false; # disable auto quote substitution
        NSAutomaticSpellingCorrectionEnabled =
          false; # disable auto spelling correction
        NSNavPanelExpandedStateForSaveMode =
          true; # expand save panel by default
        NSNavPanelExpandedStateForSaveMode2 = true;
        # use 24 hour time
        AppleICUForce24HourTime = true;
      };

      # Customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # All custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
        };
        "com.apple.finder" = {
          AppleShowAllExtensions = 1;
          FXPreferredGroupBy = "Kind";
          ShowExternalHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
        "com.apple.AdLib" = {allowApplePersonalizedAdvertising = false;};
      };

      loginwindow = {
        GuestEnabled = false; # disable guest user
        SHOWFULLNAME = true; # show full name in login window
      };
    };

    # keyboard settings is not very useful on macOS
    # the most important thing is to remap option key to alt key globally,
    # but it's not supported by macOS yet.
    keyboard = {
      swapLeftCommandAndLeftAlt = false;
    };
  };
  
  security.pam.services.sudo_local.touchIdAuth = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  # this is required if you want to use darwin's default shell - zsh
  programs.zsh.enable = true;
  environment.shells = [pkgs.zsh];
}
