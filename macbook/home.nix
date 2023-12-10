{ pkgs, ... }:

{
    imports = [
        ../home-manager/common.nix
    ];

    home.file.".config/skhd/skhdrc" = {
      text = (builtins.readFile ../dotfiles/skhdrc/general) + "\n" + (builtins.readFile ../dotfiles/skhdrc/test) + "\n";
      onChange = "${pkgs.killall}/bin/killall skhd";
    };
}