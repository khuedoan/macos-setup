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
    ghstack
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
    lima
    mosh
    neovim
    nnn
    nodePackages.npm
    nodePackages.yarn
    nodejs
    pinentry-tty
    python314
    radicle-node
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
      # "foobar"
    ];
    casks = [
      "alacritty"
      "aws-vpn-client"
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
    karabiner-elements.enable = true;
    tailscale.enable = true;
    aerospace = {
      enable = true;
      settings = {
        mode.main.binding = {
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";

          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";

          alt-ctrl-h = "join-with left";
          alt-ctrl-j = "join-with down";
          alt-ctrl-k = "join-with up";
          alt-ctrl-l = "join-with right";

          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";
          alt-7 = "workspace 7";
          alt-8 = "workspace 8";
          alt-9 = "workspace 9";
          alt-0 = "workspace 10";

          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";
          alt-shift-6 = "move-node-to-workspace 6";
          alt-shift-7 = "move-node-to-workspace 7";
          alt-shift-8 = "move-node-to-workspace 8";
          alt-shift-9 = "move-node-to-workspace 9";
          alt-shift-0 = "move-node-to-workspace 10";

          alt-tab = "workspace-back-and-forth";

          alt-f = "fullscreen --no-outer-gaps";
          alt-shift-f = "layout floating tiling";
          alt-t = "layout tiles h_accordion";

          alt-ctrl-minus = "resize smart -50";
          alt-ctrl-equal = "resize smart +50";
        };

        automatically-unhide-macos-hidden-apps = true;
      };
    };
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
  system.stateVersion = 4;
}
