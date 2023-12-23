{ pkgs, ... }:

{
    imports = [
        ../../home
    ];

    services.skhd = {
      enable = true;
      components = [
        "general"
        "emacs_nodaemon"
      ];
    };
}
