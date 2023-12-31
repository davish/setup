{ pkgs, ... }:

# https://nix-community.github.io/home-manager/options.html
{
    programs = {
        git = {
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

        zsh = {
            enable = true;
            shellAliases = {
                gcam = "git commit -am";
                gp = "git push";
                gpup = "git push -u origin $(git rev-parse --abbrev-ref HEAD)";
                gst = "git status";
                gd = "git diff";
                gs = "git switch";

                drs = "darwin-rebuild switch --flake ~/.config/nix";

                dev = "nix develop -c $SHELL";
            };
            envExtra = ''
                export PATH=$PATH:$HOME/.emacs.d/bin
            '';
        };

        direnv = {
            enable = true;
            enableZshIntegration = true;
        };

        gh.enable = true;
    };
}
