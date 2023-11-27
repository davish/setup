{ pkgs, ... }:

{
    git = {
        enable = true;
        userName = "Davis Haupt";
        userEmail = "me@davishaupt.com";
        extraConfig  = {
            init.defaultBranch = "main";
        };
    };

    zsh = {
        enable = true;
        shellAliases = {
            gcam = "git commit -am";
            gp = "git push";
            gpup = "git push -u origin $(git rev-parse --abbrev-ref HEAD)";
            gst = "git status";
            gd = "git diff";

            drs = "darwin-rebuild switch --flake ~/.config/nix";

            dev = "nix develop -c $SHELL";
        };
    };

    direnv = {
        enable = true;
        enableZshIntegration = true;
    };

    
    vscode = (import ./programs/vscode.nix) pkgs // { enable = true; };
}
