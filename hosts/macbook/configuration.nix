{ pkgs, home-manager, ... }:

{
  imports = [
    ../../darwin
  ];

  system.primaryUser = "davishaupt";

  users.users.davishaupt = {
    name = "davishaupt";
    home = "/Users/davishaupt";
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
