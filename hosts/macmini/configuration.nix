{ pkgs, ... }: 

{
    imports = [
        ../../darwin/common.nix
    ];
    users.users.davish = {
        name = "davish";
        home = "/Users/davish";
    };
    
    services.yabai.enable = true;
}