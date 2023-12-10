{ pkgs, ... }: 

{
    users.users.davish = {
        name = "davish";
        home = "/Users/davish";
    };
    
    services.yabai.enable = true;
    services.skhd.enable = true;
}