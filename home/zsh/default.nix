{ lib, config, ... }:

{
    options = {
        shell.paths = lib.mkOption {
            type = lib.types.listOf lib.types.string;
            default = [ ];
        };

        programs.zsh.shellFunctions = lib.mkOption {
            type = lib.types.attrs;
            default = {};
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
                gst  = "git status";
                gd   = "git diff";
                gs   = "git switch";
                gcaa = "git commit -a --amend --no-edit";
            };

            shellFunctions = {
                gmk = "git branch $1 && git switch $1;";
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

            envExtra = 
                let 
                    makeShellFunctions = functions: lib.strings.concatStrings 
                        (lib.attrsets.mapAttrsToList (name: value: "function ${name}() {${value}}\n") functions);
                    addPaths = lib.strings.concatMapStrings (p: "export PATH=$PATH:$HOME/${p}\n"); 
                in
            ''
            '' 
            + makeShellFunctions config.programs.zsh.shellFunctions
            + addPaths config.shell.paths;
        };
    };
}