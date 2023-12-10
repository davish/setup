{ pkgs, ... }:

{
    imports = [
        ../../home-manager/common.nix
    ];

    services.skhd = {
      enable = true;
      components = [ ../../dotfiles/skhdrc/general ../../dotfiles/skhdrc/yabai ];
    };
    
    home.file.".config/yabai/yabairc" = {
      source = ../../dotfiles/yabairc;
      onChange = "${pkgs.killall}/bin/killall yabai";
    };
}