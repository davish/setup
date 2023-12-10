{ pkgs, ... }:

{
    imports = [
        ../home-manager/common.nix
    ];
    
    home.file.".config/skhd/skhdrc" = {
      text = (builtins.readFile ../dotfiles/skhdrc/general) + "\n" + (builtins.readFile ../dotfiles/skhdrc/yabai);
      onChange = "${pkgs.killall}/bin/killall skhd";
    };

    home.file.".config/yabai/yabairc" = {
      source = ../dotfiles/yabairc;
      onChange = "${pkgs.killall}/bin/killall yabai";
    };
}