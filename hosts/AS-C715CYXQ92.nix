{ pkgs, ... }:

let
  username = "kdoan";
in
{
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    casks = [
      "royal-tsx"
      "brave-browser"
    ];
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "22.11";
      programs.home-manager.enable = true;
      home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../files/karabiner.json;
      home.packages = with pkgs; [
        argocd
        azure-cli
        cmctl
        istioctl
        jira-cli-go
        kubelogin
        sops
        terragrunt
        tflint
        yq-go
      ];
    };
  };
}
