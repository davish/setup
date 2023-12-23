{ pkgs, ... }:

let
  emacs = (import ../../darwin/emacs.nix) { pkgs = pkgs; };
in
{
    imports = [
        ../../home
    ];

    services.skhd = {
      enable = true;
      components = [
        ../../home/skhd/configs/general
        ../../home/skhd/configs/yabai
        ../../home/skhd/configs/emacsclient
      ];
    };

    services.yabai.enable = true;
    
    home.file.".doom.d".onChange = "${emacs}/bin/emacsclient -e '(doom/reload)'";

}
