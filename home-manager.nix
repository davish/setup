{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgs.tmux
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/skhd/skhdrc" = {
      source = dotfiles/skhdrc;
      onChange = "nix run nixpkgs#killall -- skhd";
    };

    ".config/yabai/yabairc" = {
      source = dotfiles/yabairc;
      onChange = "nix run nixpkgs#killall -- yabai";
    };

    ".config/karabiner.edn" = {
      source = dotfiles/karabiner.edn;
      onChange = "nix run nixpkgs#goku";
    };
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/davish/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Davis Haupt";
    userEmail = "me@davishaupt.com";
    extraConfig  = {
      init.defaultBranch = "main";
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      gcam = "git commit -am";
      gp = "git push";
      gpup = "git push -u origin $(git rev-parse --abbrev-ref HEAD)";
      gst = "git status";

      drs = "darwin-rebuild switch --flake ~/.config/nix";

      dev = "nix develop -c $SHELL";
    };
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  
  programs.vscode =  {
    enable = true;
    extensions = [
      pkgs.vscode-extensions.vscodevim.vim
      pkgs.vscode-extensions.bbenoist.nix 
      pkgs.vscode-extensions.vspacecode.vspacecode
      pkgs.vscode-extensions.vspacecode.whichkey
    ];
    
    userSettings = let vSpaceCodeLaunch = {
        "before" = [ "<space>" ];
        "commands" = [ "vspacecode.space" ];
    }; in {
      "vim.easymotion" = true;
      "vim.useSystemClipboard" = true;
      "vim.normalModeKeyBindingsNonRecursive" = [ vSpaceCodeLaunch ];
      "vim.visualModeKeyBindingsNonRecursive" = [ vSpaceCodeLaunch ];
      "workbench.colorTheme" = "Nord Light";
    };
  };
}
