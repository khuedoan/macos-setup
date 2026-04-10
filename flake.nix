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
    mkDarwinConfiguration = { system, userModule, hostModule }:
      darwin.lib.darwinSystem {
        inherit system;
        modules = baseModules ++ [
          userModule
          hostModule
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
  in {
    darwinConfigurations = {
      "MacBookAir" = mkDarwinConfiguration {
        system = "aarch64-darwin";
        userModule = ./users/khuedoan;
        hostModule = ./hosts/MacBookAir;
      };
      "MacBookPro" = mkDarwinConfiguration {
        system = "aarch64-darwin";
        userModule = ./users/khuedoan;
        hostModule = ./hosts/MacBookPro;
      };
      "AS-GXL19NXYYQ" = mkDarwinConfiguration {
        system = "aarch64-darwin";
        userModule = ./users/kdoan;
        hostModule = ./hosts/AS-GXL19NXYYQ;
      };
      "test" = mkDarwinConfiguration {
        system = "aarch64-darwin";
        userModule = ./users/runner;
        hostModule = ./hosts/test;
      };
    };
  };
}
