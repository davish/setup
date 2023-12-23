{ pkgs, lib, config, ... }:

{
    options.services.yabai = {
        enable = lib.mkEnableOption "yabai";
    };

    config = {
        home.file.".config/yabai/yabairc" = lib.mkIf config.services.yabai.enable {
            source = ./yabairc;
            onChange = "${pkgs.killall}/bin/killall yabai";
        };
    };
}