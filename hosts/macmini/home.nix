{ pkgs, ... }:

let
  emacs = (import ../../darwin/emacs.nix) { pkgs = pkgs; };
in
{
  imports = [
    ../../home
  ];

}
