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
    pkgs-unstable = import nixpkgs-unstable {
      system = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations = {
      "MacBookAir" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit pkgs-unstable; };
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./hosts/MacBookAir.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      "MacBookPro" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit pkgs-unstable; };
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./hosts/MacBookPro.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      "AS-GXL19NXYYQ" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit pkgs-unstable; };
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./hosts/AS-GXL19NXYYQ.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      "test" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit pkgs-unstable; };
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./hosts/test.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
    };
  };
}
