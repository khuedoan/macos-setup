{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep curl
  environment.systemPackages = with pkgs; [
    aria
    bat
    cargo
    colima
    coreutils
    curl
    docker
    fd
    fzf
    gh
    git
    gnupg
    go
    jq
    k9s
    kubectl
    kubectl-tree
    kubectx
    kubernetes-helm
    kustomize
    mosh
    neovim
    nnn
    nodePackages.npm
    nodePackages.yarn
    nodejs
    pinentry-tty
    radicle-node
    rbw
    ripgrep
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

    (pass.withExtensions (ext: with ext; [
      pass-otp
    ]))
  ];

  # TODO remove this https://github.com/LnL7/nix-darwin/issues/1041
  nixpkgs.overlays = [
    (self: super: {
      karabiner-elements = super.karabiner-elements.overrideAttrs (old: {
        version = "14.13.0";
        src = super.fetchurl {
          inherit (old.src) url;
          hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
        };
      });
    })
  ];

  environment.systemPath = [
    config.homebrew.brewPrefix # TODO https://github.com/LnL7/nix-darwin/issues/596
  ];

  fonts = {
    packages = [
      (pkgs.nerdfonts.override {
        fonts = [
          "FiraCode"
        ];
      })
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
      # "foobar"
    ];
    casks = [
      "kitty"
      "linearmouse"
      "utm"
    ];
  };

  system.defaults = {
    alf = {
      globalstate = 1;
    };
    dock = {
      autohide = true;
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
    karabiner-elements.enable = true;
    tailscale.enable = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

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

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
