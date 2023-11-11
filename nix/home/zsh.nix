{ ... }: {
  programs.zsh= {
    enable = true;
    enableCompletion = true;

	oh-my-zsh = {
	  enable = true;
	  plugins = [ "git" 
	  "zoxide"
	  "extract"
	  "zsh-autosuggestions"
	  "git-open"
	  "zsh-syntax-highlighting"
	  ];
	};
  };
}
