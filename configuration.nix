{ config, pkgs, pkgs-unstable, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep curl
  environment.systemPackages = with pkgs; [
    aria2
    backblaze-b2
    bat
    cargo
    colima
    coreutils
    curl
    docker
    dyff
    fd
    fzf
    gh
    ghstack
    git
    gnupg
    go
    imagemagick
    inetutils
    jq
    k9s
    kubectl
    kubectl-tree
    kubectx
    kubernetes-helm
    kustomize
    lima
    markdown-oxide
    mosh
    neovim
    nnn
    pinentry-tty
    python314
    rbw
    ripgrep
    sapling
    tmux
    tree
    unzip
    watch
    zoxide

    # Language servers
    gopls
    lua-language-server
    nil
    nodePackages.typescript-language-server
    pyright
    rust-analyzer
    terraform-ls

    # AI
    pkgs-unstable.opencode
    pkgs-unstable.codex
    pkgs-unstable.playwright-mcp

    (pass.withExtensions (ext: with ext; [
      pass-import
      pass-otp
    ]))
  ];

  environment.systemPath = [
    config.homebrew.brewPrefix # TODO https://github.com/LnL7/nix-darwin/issues/596
  ];

  fonts = {
    packages = with pkgs; [
      nerd-fonts.fira-code
    ];
  };

  # Homebrew packages
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    taps = [
      # { name = "homebrew/foobar"; }
    ];
    brews = [
      "ollama"
    ];
    casks = [
      "kitty"
      "linearmouse"
      "secretive"
      "utm"
      "zen"
    ];
  };

  system.defaults = {
    dock = {
      autohide = true;
      expose-group-apps = true;
      minimize-to-application = true;
      mru-spaces = false;
      showhidden = true;
    };
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      ApplePressAndHoldEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
    CustomUserPreferences = {
      "com.apple.Safari" = {
        AlwaysRestoreSessionAtLaunch = true;
        AutoOpenSafeDownloads = false;
        EnableNarrowTabs = false;
        IncludeDevelopMenu = true;
        NeverUseBackgroundColorInToolbar = true;
        ShowFullURLInSmartSearchField = true;
        ShowOverlayStatusBar = true;
        ShowStandaloneTabBar = false;
      };
    };
  };

  services = {
    # TODO some machine have the driver blocked, needs to install from the web
    # And Karabiner on nix-darwin is currently broken https://github.com/LnL7/nix-darwin/issues/1041
    # karabiner-elements.enable = true;
    tailscale.enable = true;
  };

  nix = {
    # configureBuildUsers = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      allowed-users = [
        "@admin"
      ];
    };
    optimise = {
      automatic = true;
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs = {
    zsh = {
      enable = true;
      enableBashCompletion = false;
      enableCompletion = false;
      promptInit = "";
    };
    direnv = {
      enable = true;
      silent = true;
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;
}
