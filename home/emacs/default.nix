{ pkgs, config, lib, home-manager, ... }:

let 
    # TODO: make this work on non-mac systems
    emacs = (import ../../darwin/emacs.nix) { pkgs = pkgs; };
in
{
    options.services.emacs-daemon = {
        enable = lib.mkEnableOption "enable emacs daemon";
    };

    config = {
        home.file.".doom.d" = {
            source = ./doom;
        };

        home.file.".doom.d".onChange = lib.mkIf config.services.emacs-daemon.enable "${emacs}/bin/emacsclient -e '(doom/reload)'";

        home.activation.install-doom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          if ! [ -d "$HOME/.emacs.d" ]; then
            $DRY_RUN_CMD ${
              lib.getExe pkgs.git
            } clone $VERBOSE_ARG --depth=1 --single-branch "https://github.com/doomemacs/doomemacs.git" "$HOME/.emacs.d";
          fi
        '';
    };
    
}