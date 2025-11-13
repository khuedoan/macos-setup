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
      "aws-vpn-client"
      "brave-browser"
      "cursor"
      "royal-tsx"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
      home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../files/karabiner.json;
      home.file.".config/kitty/kitty.d/macos.conf".text = builtins.readFile ../files/kitty.conf;
      home.packages = with pkgs; [
        acr-cli
        argocd
        awscli2
        azure-cli
        cmctl
        istioctl
        jira-cli-go
        kubelogin
        sops
        ssm-session-manager-plugin
        tenv
        tflint
        yq-go
      ];
    };
  };
}
