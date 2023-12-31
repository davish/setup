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
        "general"
        "yabai"
        "emacs_nodaemon"
      ];
    };

    services.yabai.enable = true;
    # services.emacs-daemon.enable = true;
}
