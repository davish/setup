{ pkgs, home-manager, ... }: 

{
    imports = [
        ../../darwin/common.nix
    ];

    users.users.davishaupt = {
        name = "davishaupt";
        home = "/Users/davishaupt";
    };

    security.pam.enableSudoTouchIdAuth = true;
}