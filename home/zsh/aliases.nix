{ lib, config, ... }:

{
  programs.zsh.shellAliases = {
    rrc = "source ~/.zshenv && source ~/.zshrc";
    sw = "darwin-rebuild switch --flake ~/.config/nix";

    dev = "nix develop -c $SHELL";

    jgi = "jj init --git-repo=.";

    gcam = "git commit -am";
    gp = "git push";
    gst = "git status";
    gd = "git diff";
    gs = "git switch";
    gcaa = "git commit -a --amend --no-edit";
  };

  programs.zsh.shellFunctions = {
    gmk = ''git branch $1 
                git switch $1
        '';
  };
}
