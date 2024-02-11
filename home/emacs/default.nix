{ pkgs, config, lib, home-manager, ... }:

let 
    # TODO: make this work on non-mac systems
    emacs = (import ../../darwin/emacs.nix) { pkgs = pkgs; };
in
{
    options = {
        services.emacs-daemon = {
            enable = lib.mkEnableOption "enable emacs daemon";
        };
        my.emacs.vanilla = {
            enable = lib.mkEnableOption "use vanilla emacs over Doom";
        };
    };

    config = {
        home.file.".doom.d" = lib.mkIf (!config.my.emacs.vanilla.enable) {
            source = ./doom;
            onChange = lib.mkIf config.services.emacs-daemon.enable "${emacs}/bin/emacsclient -e '(doom/reload)'";
        };

        home.file.".emacs.d" = lib.mkIf (config.my.emacs.vanilla.enable) {
            source = ./vanilla;
            # straight.el installs itself in .emacs.d, so we should recursively link our config 
            # files there rather than creating a symlink to the entire directory.
            recursive = true;
        };

        home.activation.install-doom = lib.hm.dag.entryAfter [ "writeBoundary" ] (if config.my.emacs.vanilla.enable then "" else ''
          if ! [ -d "$HOME/.emacs.d" ]; then
            $DRY_RUN_CMD ${
              lib.getExe pkgs.git
            } clone $VERBOSE_ARG --depth=1 --single-branch "https://github.com/doomemacs/doomemacs.git" "$HOME/.emacs.d";
          fi
        '');

        shell.paths = [ ".emacs.d/bin" ];
    };
    
}