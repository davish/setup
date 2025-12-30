{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs =
    inputs@{ self
    , nix-darwin
    , home-manager
    , nixpkgs
    , mac-app-util
    , nix-vscode-extensions
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#davish-desktop
      darwinConfigurations."davish-desktop" = nix-darwin.lib.darwinSystem {
        specialArgs = inputs;
        modules = [
          ./hosts/macmini/configuration.nix

          # mac-app-util.darwinModules.default

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            # TODO: Re-enable once iterate package from gitlab.common-lisp.net is fixed
            # home-manager.sharedModules = [
            #   mac-app-util.homeManagerModules.default
            # ];
            home-manager.users.davish.imports = [
              ./hosts/macmini/home.nix
            ];
          }
        ];
      };

      darwinConfigurations."Daviss-MacBook-Air" = nix-darwin.lib.darwinSystem {
        specialArgs = inputs;
        modules = [
          ./hosts/macbook/configuration.nix

          mac-app-util.darwinModules.default

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
            home-manager.users.davishaupt.imports = [
              ./hosts/macbook/home.nix
            ];
          }
        ];
      };

      darwinConfigurations."air2" = nix-darwin.lib.darwinSystem {
        specialArgs = inputs;
        modules = [
          ./hosts/air2/configuration.nix

          mac-app-util.darwinModules.default

          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
            home-manager.users.dhaupt.imports = [
              ./hosts/macbook/home.nix
            ];
          }
        ];
      };
    };
}
