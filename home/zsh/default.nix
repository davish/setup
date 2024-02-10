{ ... }:

{
    programs.zsh = {
        enable = true;
        shellAliases = {
            rrc = "source ~/.zshrc";
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
        envExtra = ''
            export PATH=$PATH:$HOME/.emacs.d/bin

            function ancestors() {
                git log --oneline --decorate --decorate-refs="heads" --simplify-by-decoration "main..HEAD" --format="%D" | tr ', ' '\n' | tr -s '\n'
            }
        '';
    };
}