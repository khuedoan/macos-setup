{ pkgs, ... }:

let
  username = "kdoan";
in
{
  system.primaryUser = username;
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    casks = [
      "brave-browser"
      "cursor"
      "royal-tsx"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../files/karabiner.json;
      home.file.".config/kitty/kitty.d/macos.conf".text = builtins.readFile ../files/kitty.conf;
      home.file.".config/ghostty/config".text = builtins.readFile ../files/ghostty;
      home.packages = with pkgs; [
        argocd
        awscli2
        azure-cli
        cmctl
        istioctl
        jira-cli-go
        kubelogin
        sops
        tenv
        tflint
        yq-go
      ];
    };
  };
}
