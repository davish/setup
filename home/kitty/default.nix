{ pkgs, ... }:

{
    home.file.".config/kitty/themes/Nord Light.conf" = {
        source = ./nord-light-theme.kitty.conf;
    };
}
    