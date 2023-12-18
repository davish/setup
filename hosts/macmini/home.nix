{ pkgs, ... }:

let
  emacs = (import ../../darwin/emacs.nix) { pkgs = pkgs; };
in
{
    imports = [
        ../../home-manager
    ];

    services.skhd = {
      enable = true;
      components = [
        ../../dotfiles/skhdrc/general
        ../../dotfiles/skhdrc/yabai
        ../../dotfiles/skhdrc/emacsclient
      ];
    };
    
    home.file.".config/yabai/yabairc" = {
      source = ../../dotfiles/yabairc;
      onChange = "${pkgs.killall}/bin/killall yabai";
    };

    home.file.".doom.d".onChange = "${emacs}/bin/emacsclient -e '(doom/reload)'";
}
