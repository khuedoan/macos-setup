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
      home.file.".config/kitty/kitty.d/macos.conf".text = builtins.readFile ../files/kitty.conf;
      home.packages = with pkgs; [
        argocd
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
