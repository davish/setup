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

            initExtra = ''
                # Search through history with prefix that's already typed.
                # https://unix.stackexchange.com/questions/621606/zsh-completion-with-up-and-down-arrows
                autoload -U up-line-or-beginning-search
                autoload -U down-line-or-beginning-search
                zle -N up-line-or-beginning-search
                zle -N down-line-or-beginning-search
                bindkey "^[[A" up-line-or-beginning-search
                bindkey "^[[B" down-line-or-beginning-search
            '';

            envExtra = lib.strings.concatMapStrings (p: "export PATH=$PATH:$HOME/${p}\n") config.shell.paths;
        };
    };
}