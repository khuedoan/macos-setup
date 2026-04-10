{ ... }:

{
  homebrew = {
    casks = [
      "diffusionbee"
    ];
    masApps = {
      # Need to be signed into the Mac App Store
      "Bitwarden" = 1352778147;
      "WireGuard" = 1451685025;
    };
  };

  # TODO clean up
  system.activationScripts.extraUserActivation.text = ''
    sudo pmset -a lowpowermode 1
  '';
}
