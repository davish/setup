{ ... }:

{
    programs.git = {
        enable = true;
        userName = "Davis Haupt";
        userEmail = "me@davishaupt.com";
        ignores = [ ".DS_Store" ".direnv" ];
        difftastic = {
            enable = true;
            display = "inline";
        };

        extraConfig  = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
        };
    };

    programs.gh.enable = true;
}