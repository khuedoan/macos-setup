{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    aria
    cargo
    colima
    curl
    direnv
    docker
    fzf
    gh
    git
    gnupg
    go
    jq
    kubectl
    kubernetes-helm
    kustomize
    neovim
    nnn
    nodePackages.npm
    nodePackages.yarn
    nodejs
    ripgrep
    tmux
    tree
    unzip
    watch
    zoxide

    (pass.withExtensions (ext: with ext; [pass-otp]))

    # TODO
    (google-cloud-sdk.withExtraComponents [
      pkgs.google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
  ];

  fonts = {
    fontDir.enable = true;
    fonts = [
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
      { name = "homebrew/cask"; }
      # TODO ARM support
      # { name = "kde-mac/kde"; clone_target = "https://invent.kde.org/packaging/homebrew-kde.git"; force_auto_update = true; }
    ];
    brews = [
      # "foobar"
    ];
    casks = [
      "alacritty"
      # "brave-browser"
      "firefox"
      "syncthing"
      "zerotier-one"
      # TODO ARM support
      # "kdeconnect"
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
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };

  # TODO clean up
  system.activationScripts.extraUserActivation.text = ''
    sudo pmset -a lowpowermode 1
  '';

  services.karabiner-elements = {
    enable = true;
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix = {
    # configureBuildUsers = true;
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      allowed-users = [
        "@admin"
      ];
    };
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    enableBashCompletion = false;
    enableCompletion = false;
    promptInit = "";
  };

  security.pam.enableSudoTouchIdAuth = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # TODO clean up
  # home-manager = {
  #   useUserPackages = true;
  #   useGlobalPkgs = true;
  #   users.khuedoan = { pkgs, lib, ... }: {
  #     home.stateVersion = "22.05";
  #     programs.home-manager.enable = true;
  #     home.file.".config/alacritty/alacritty.yml".text = builtins.readFile ./alacritty.yml;
  #     home.file.".config/karabiner/karabiner.json".text = builtins.readFile ./karabiner.json;
  #   };
  # };
}
