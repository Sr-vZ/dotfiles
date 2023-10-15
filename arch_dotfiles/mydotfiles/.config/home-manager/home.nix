{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "srvz";
  home.homeDirectory = "/home/srvz";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    zsh
    tmux
    zellij
    python3
    go
    lf
    fzf
    ripgrep
    zoxide
    git
    gitui
    eza
    bat
    htop
    btop
    neovim
    helix
  ];

  programs.zsh = {
  	enable = true;
  	enableAutosuggestions = true;
  	enableCompletion = true;
  	initExtra = "
		source $HOME/.zshrc
  	";
  	plugins = with pkgs; [
  		{
	  		name = "powerlevel10k";
	  		src = zsh-powerlevel10k;
	  		file = "~/.p10k.zsh";
  		}
		{
	        name = "zsh-syntax-highlighting";
	        src = fetchFromGitHub {
	          owner = "zsh-users";
	          repo = "zsh-syntax-highlighting";
	          rev = "0.6.0";
	          sha256 = "0zmq66dzasmr5pwribyh4kbkk23jxbpdw4rjxx0i7dx8jjp2lzl4";
	        };
	        file = "zsh-syntax-highlighting.zsh";
		}
  		# {
  		# 	name =  
  		# }
  	];
  };

  # programs.zsh.plugins = [
  # 	{
  # 		name = "powerlevel10k";
  # 		src = pkgs.zsh-powerlevel10k;
  # 		file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  # 	}
  # 	{
  # 		name = "powerlevel10k-config";
  # 		src = "./";
  # 		file = ".p10k.zsh";
  # 	}
  # ];
  

  programs.fzf = {
  	enable = true;
  };

  programs.zoxide = {
  	enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/srvz/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
