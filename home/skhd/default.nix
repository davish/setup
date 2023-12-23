{ pkgs, config, lib, home-manager, ... }:

{
  options.services.skhd = {
    enable = lib.mkEnableOption "skhd configuration";
    components = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [ ];
    };
  };

  config = {
      home.file.".config/skhd/skhdrc" = lib.mkIf config.services.skhd.enable {
        text = lib.strings.concatStrings (lib.strings.intersperse "\n" (map builtins.readFile config.services.skhd.components));
        onChange = "${pkgs.killall}/bin/killall skhd";
      };
  };
}