{
  description = "Khue's macOS setup";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    };
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager }: {
    darwinConfigurations = {
      "MacBookAir" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./hosts/MacBookAir.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
      "AS-GXL19NXYYQ" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          ./hosts/AS-GXL19NXYYQ.nix
        ];
        inputs = { inherit nixpkgs darwin home-manager; };
      };
    };
  };
}
