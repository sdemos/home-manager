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

  home.packages = [
    # Test package
    pkgs.hello

    # Tools
    pkgs.ripgrep
    pkgs.htop
  ];

  #### Dot Files ####

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

  #### Environment Variables ####

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/demos/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "vim";
  };

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
