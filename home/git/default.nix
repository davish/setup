{ ... }:

{
  programs.git = {
    enable = true;

    userName = "Davis Haupt";
    userEmail = "me@davishaupt.com";

    ignores = [
      ".DS_Store"
      ".direnv"
      ".jj"
    ];

    difftastic = {
      enable = true;
      display = "inline";
    };

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      pull.ff = "only";
      merge.conflictstyle = "zdiff3";
    };
  };

  programs.gh.enable = true;
}
