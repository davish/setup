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

    # Only run the Emacs daemon on the desktop because it takes up too much
    # battery life on an M1 macbook.
    # TODO: Maybe have some kind of flag for power-hungry background processes?
    #
    # In order for emacsclient to tile properly, the daemon needs to be run
    # through the emacs app rather than the executable. Don't ask me why, only
    # denvercoder9 knows for sure:
    # https://github.com/koekeishiya/yabai/issues/86#issuecomment-1615158207
    launchd.user.agents.emacs = {
        path = [config.environment.systemPath];
        serviceConfig = {
            ProgramArguments = [ "open" "-W" "-a" "Emacs" "--args" "--fg-daemon"];
            RunAtLoad = true;
            KeepAlive = true;
        };
    };
    home.file.".doom.d".onChange = "${emacs}/bin/emacsclient -e '(doom/reload)'";
}
