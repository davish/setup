{ pkgs, ... }:

# https://nix-community.github.io/home-manager/options.html
{
    vscode = (import ./programs/vscode.nix) pkgs // { enable = true; };

    git = {
        enable = true;
        userName = "Davis Haupt";
        userEmail = "me@davishaupt.com";
        ignores = [ ".DS_Store" ];
        difftastic = {
            enable = true;
            display = "inline";
        };

        extraConfig  = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
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


    kitty = {
        enable = true;
        shellIntegration.enableZshIntegration = true;

        # The kitty.themes setting doesn't support
        extraConfig = ''
            include themes/Nord Light.conf
            '';
    };
}
