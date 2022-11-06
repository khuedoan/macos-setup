{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    cargo
    curl
    fzf
    git
    jq
    neovim
    nodePackages.npm
    nodejs
    ripgrep
    tmux
    tree
    unzip
    zoxide
  ];

  fonts = {
    fontDir.enable = true;
    fonts = [
      (pkgs.nerdfonts.override {
        fonts = ["FiraCode"];
      })
    ];
  };

  # Homebrew packages
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      "homebrew/cask"
    ];
    brews = [
      # "foobar"
    ];
    casks = [
      "alacritty"
    ];
  };

  system.defaults = {
    # alf = {
    #   globalstate = 1;
    # };
    dock = {
      autohide = true;
      minimize-to-application = true;
      mru-spaces = false;
      showhidden = true;
      # magnification = true;
    };
    NSGlobalDomain = {
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };

  services.karabiner-elements = {
    enable = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
