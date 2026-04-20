{
  description = "Khue's macOS setup";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-25.11-darwin";
    };
    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, darwin, home-manager }:
  let
    baseModules = [
      ./configuration.nix
      home-manager.darwinModules.home-manager
      {
        nixpkgs.overlays = [
          (final: prev: {
            unstable = import nixpkgs-unstable {
              inherit (prev.stdenv.hostPlatform) system;
              config = prev.config;
            };
          })
        ];
      }
    ];
  in {
    darwinConfigurations = {
      "MacBookPro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = baseModules ++ [
          ./users/khuedoan
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      "AS-GXL19NXYYQ" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = baseModules ++ [
          ./users/kdoan
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      "test" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = baseModules ++ [
          {
            # User in GitHub Actions runner
            system.primaryUser = "runner";
            users.users.runner.home = "/Users/runner";
            # TODO not sure why Linux builder doesn't work yet, likely due to bootstrapping
            nix.linux-builder.enable = nixpkgs.lib.mkForce false;
            home-manager = {
              useUserPackages = true;
              useGlobalPkgs = true;
              users.runner = { pkgs, ... }: {
                home.stateVersion = "25.11";
                programs.home-manager.enable = true;
              };
            };
          }
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
    };
  };
}
