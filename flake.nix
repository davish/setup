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
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#davish-desktop
    darwinConfigurations."davish-desktop" = nix-darwin.lib.darwinSystem {
      modules = [ 
         ./hosts/macmini/darwin.nix

         home-manager.darwinModules.home-manager {
             home-manager.useGlobalPkgs = true;
             home-manager.useUserPackages = true;
             home-manager.verbose = true;
             home-manager.users.davish = import ./hosts/macmini/home.nix;
         }
      ];
    };

    darwinConfigurations."Daviss-MacBook-Air" = nix-darwin.lib.darwinSystem {
      modules = [ 
         ./hosts/macbook/darwin.nix

         home-manager.darwinModules.home-manager {
             home-manager.useGlobalPkgs = true;
             home-manager.useUserPackages = true;
             home-manager.verbose = true;
             home-manager.users.davishaupt = import ./hosts/macbook/home.nix;
         }
      ];
    };
  };
}
