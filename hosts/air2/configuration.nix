{ pkgs, home-manager, ... }:

{
  imports = [
    ../../darwin
  ];

  system.primaryUser = "dhaupt";

  users.users.dhaupt = {
    name = "dhaupt";
    home = "/Users/dhaupt";
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
