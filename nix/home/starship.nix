{ lib, ... }: {
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = {
      # character = {
      #   success_symbol = "[›](bold green)";
      #   error_symbol = "[›](bold red)";
      # };
      # aws = {
      #   symbol = "🅰 ";
      # };
      # gcloud = {
      #   # do not show the account/project's info
      #   # to avoid the leak of sensitive information when sharing the terminal
      #   format = "on [$symbol$active(\($region\))]($style) ";
      #   symbol = "🅶 ️";
      # };
      format = concatStrings [
          "$username"
          "$package"
          "$hostname"
          "$directory"
          "$git_branch"
          "$git_state"
          "$git_status"
          "$cmd_duration"
          "$line_break"
          "$python"
          "$character"
          ];
      directory.style = "blue";
      character ={
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_branch ={
        format = "[$branch]($style)";
        style = "bright-black";
      };
      git_status ={
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "";
        untracked = "";
        modified = "";
        staged = "";
        renamed = "";
        deleted = "";
        stashed = "≡";
      };
      git_state = {
        format = "'\([$state( $progress_current/$progress_total)]($style)\) '";
        style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      python ={
        format = "[$virtualenv]($style) ";
        style = "bright-black";
      };
    };
  };
}
