{ lib, config, ... }:

{
    options = {
        shell.paths = lib.mkOption {
            type = lib.types.listOf lib.types.string;
            default = [ ];
        };
    };

    config = {
        programs.zsh = {
            enable = true;
            shellAliases = {
                rrc = "source ~/.zshenv && source ~/.zshrc";
                sw = "darwin-rebuild switch --flake ~/.config/nix";

                dev = "nix develop -c $SHELL";

                jgi = "jj init --git-repo=.";

                gcam = "git commit -am";
                gp   = "git push";
                gpup = "git push -u origin $(git rev-parse --abbrev-ref HEAD)";
                gst  = "git status";
                gd   = "git diff";
                gs   = "git switch";
            };

            envExtra = lib.strings.concatMapStrings (p: "export PATH=$PATH:$HOME/${p}\n") config.shell.paths;
        };
    };
}