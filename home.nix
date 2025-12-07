{ config, pkgs, ... }:

{
  # TODO: move these to the flake. If I want this to eventually work across
  # platforms, my understanding is the flake handles those platform parameters
  # and the home.nix file here handles the details I want to be the same across
  # platforms.
  home.username = "demos";
  home.homeDirectory = "/Users/demos";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  #### Packages ####
  home.packages = with pkgs; [
    # Test package
    hello

    # Tools
    ripgrep
    htop
    nixfmt-rfc-style
    wget
    curl
  ];

  #### Dot Files ####
  home.file = { };

  #### Environment Variables ####
  home.sessionVariables = { };

  #### Program Configuration ####

  # Git
  programs.git = {
    enable = true;
    settings = {
      user.name = "Stephen Demos";
      user.email = "stephen@demos.zone";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  # Tmux
  programs.tmux = {
    enable = true;
    mouse = true;
  };

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "git-prompt"
        "rust"
        "ssh"
        "sudo"
        "tmux"
      ];
      theme = "demos";
      # A notable behavior here - using the ${} syntax tells nix to take this
      # directory and put it in the nix store, and then reference that here.
      # This is pretty cool! Of course it means I have to run home-manager
      # switch any time I change anything but that's not so bad, it's not like
      # my theme changes that often (it's been about 10 years??)
      custom = "${./ohmyzsh}";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
