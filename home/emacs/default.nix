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
  };

  config = {
    home.file.".emacs.d" = {
      source = ./vanilla;
      # straight.el installs itself in .emacs.d, so we should recursively link our config 
      # files there rather than creating a symlink to the entire directory.
      recursive = true;
    };

    shell.executablePaths = [ ".emacs.d/bin" ];
  };

}
