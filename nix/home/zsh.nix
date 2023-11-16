{ ... }: {
  programs.zsh= {
    enable = true;
    enableCompletion = true;
	enableAutosuggestions = true;
	syntaxHighlighting.enable = true;

	oh-my-zsh = {
	  enable = true;
	  plugins = [ "git" ];
	};

	shellAliases = {
		ea = "eza -la --git";
		alias ea="eza -la --git";
		# achrome="open -n /Applications/Google\ Chrome\ Dev.app/ --args --disable-web-security  --user-data-dir=/Users/rick/Downloads/chromeDevData";
		gck="git checkout";
		gsu="git submodule update --remote";
		gft="git difftool --no-symlinks --dir-diff";
		glg="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
		icat="kitty +kitten icat";
		vim="nvim";
		tma="tmux a -t";
		tml="tmux ls";
		lg="lazygit";
		pm="pnpm";
	};
  };
}
