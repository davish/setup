{ pkgs, ... }:

{
    imports = [
        ../../home-manager
    ];

    services.skhd = {
      enable = true;
      components = [
        ../../dotfiles/skhdrc/general
        ../../dotfiles/skhdrc/emacs_nodaemon
      ];
    };
}
