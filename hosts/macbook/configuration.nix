{ pkgs, home-manager, ... }: 

{
    imports = [
        ../../darwin
    ];

    users.users.davishaupt = {
        name = "davishaupt";
        home = "/Users/davishaupt";
    };

    security.pam.enableSudoTouchIdAuth = true;
}