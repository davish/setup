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
    gmk = ''
      git branch $1 
      git switch $1'';

    vscode-hash = ''
      if [ "$#" -ne 3 ]; then
        echo "Error: This function requires exactly 3 arguments"
        echo "Usage: $0 <PUBLISHER> <NAME> <VERSION>"
        return 1
      fi
      publisher=$1
      name=$2
      version=$3
      url="https://$publisher.gallery.vsassets.io/_apis/public/gallery/publisher/$publisher/extension/$name/$version/assetbyname/Microsoft.VisualStudio.Services.VSIXPackage"
      curl $url | sha256sum'';
  };
}
