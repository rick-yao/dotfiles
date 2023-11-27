{ ... }: {
  programs.zsh= {
    enable = true;
    enableCompletion = true;
		enableAutosuggestions = true;
		syntaxHighlighting.enable = true;

	oh-my-zsh = {
	  enable = true;
	  plugins = [ "git" "zoxide" ];
	};

	shellAliases = {
		cd = "z";
		ea = "eza -la --git";
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
		achrome="open -n /Applications/Google\ Chrome\ Dev.app/ --args --disable-web-security  --user-data-dir=/Users/rick/Downloads/chromeDevData";
		showFiles="defaults write com.apple.finder AppleShowAllFiles -boolean true ; killall Finder";
		hideFiles="defaults write com.apple.finder AppleShowAllFiles -boolean false ; killall Finder";
		brewcl="brew cleanup -s --prune=all";
		brewup="brew upgrade; brewcl";
		cache-clear="
			yarn cache clean; 
			npm cache clean -force;
			pnpm store prune;
			pod cache clean --all;
			brewcl;rm -rf ~/.gradle/cache;
			rm -rf ~/Library/Developer/Xcode/DerivedData;
			rm -rf ~/Library/Developer/Xcode/Archives;
			rm -rf ~/.bun/install/cache/;
			";
		fly="env https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890";
		fle="export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890";
		cnpm="npm --registry=https://registry.npmmirror.com  --cache=$HOME/.npm/.cache/cnpm  --disturl=https://npmmirror.com/mirrors/node  --userconfig=$HOME/.cnpmrc";
		f="yazi";
	};
	dotDir = ".config/zsh";
	envExtra ={
		AAA = "~/.config";
	}
  };
}
