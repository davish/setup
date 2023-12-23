{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
    home.file.".config/karabiner.edn" = lib.mkIf isDarwin {
        source = ./karabiner.edn;
        onChange = "${pkgs.goku}/bin/goku";
    };
}