{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:davish/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs, mac-app-util }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#davish-desktop
      darwinConfigurations."davish-desktop" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/macmini/configuration.nix

          mac-app-util.darwinModules.default

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.davish.imports = [ ./hosts/macmini/home.nix mac-app-util.homeManagerModules.default ];
          }
        ];
      };

      darwinConfigurations."Daviss-MacBook-Air" = nix-darwin.lib.darwinSystem {
        modules = [
          ./hosts/macbook/configuration.nix

          mac-app-util.darwinModules.default

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.davishaupt.imports = [ ./hosts/macbook/home.nix mac-app-util.homeManagerModules.default ];
          }
        ];
      };
    };
}
