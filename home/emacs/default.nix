{ pkgs, config, lib, home-manager, ... }:

let 
    emacs = (import ../../darwin/emacs.nix) { pkgs = pkgs; };
in
{
    home.file.".doom.d" = {
        source = ./doom;
    };

    home.activation.install-doom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if ! [ -d "$HOME/.emacs.d" ]; then
        $DRY_RUN_CMD ${
          lib.getExe pkgs.git
        } clone $VERBOSE_ARG --depth=1 --single-branch "https://github.com/doomemacs/doomemacs.git" "$HOME/.emacs.d";
      fi
    '';
}