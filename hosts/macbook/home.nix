{ pkgs, ... }:

{
    imports = [
        ../../home
    ];

    services.skhd = {
      enable = true;
      components = [
        ../../home/skhd/configs/general
        ../../home/skhd/configs/emacs_nodaemon
      ];
    };
}
