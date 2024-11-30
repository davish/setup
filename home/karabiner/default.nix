{ pkgs, lib, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  # If karabiner ever stops working and restarts don't fix the problem, try:
  # /Applications/.Nix-Karabiner/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager deactivate
  # then restarting and re-allowing Karabiner when prompted.

  home.file.".config/karabiner.edn" = lib.mkIf isDarwin {
    source = ./karabiner.edn;
    onChange = "${pkgs.goku}/bin/goku";
  };
}
