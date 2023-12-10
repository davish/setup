{ pkgs, ... }:

{
    imports = [
        ../home-manager/common.nix
    ];

    services.skhd = {
      enable = true;
      components = [ ../dotfiles/skhdrc/general ];
    };
}