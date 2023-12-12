{ pkgs, ... }: 

{
    imports = [
        ../../darwin
    ];
    users.users.davish = {
        name = "davish";
        home = "/Users/davish";
    };
    
    services.yabai.enable = true;
}