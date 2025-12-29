{ pkgs, ... }:

let
  username = "khuedoan";
in
{
  system.primaryUser = username;
  # TODO https://github.com/LnL7/nix-darwin/issues/682
  users.users.${username}.home = "/Users/${username}";

  homebrew = {
    casks = [
      "brave-browser"
      "iina"
      "signal"
      "steam"
    ];
    masApps = {
      # Need to be signed into the Mac App Store
      "Bitwarden" = 1352778147;
      "WireGuard" = 1451685025;
    };
  };

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.${username} = { pkgs, lib, ... }: {
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
      home.file.".config/karabiner/karabiner.json".text = builtins.readFile ../files/karabiner.json;
      home.file.".config/kitty/kitty.d/macos.conf".text = builtins.readFile ../files/kitty.conf;
    };
  };
}
