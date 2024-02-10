{ ... }:

{
    programs.zsh = {
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
}