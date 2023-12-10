{ useYabai }: 

{ pkgs, ... }:

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
    pkgs.tmux
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/karabiner.edn" = {
      source = ../dotfiles/karabiner.edn;
      onChange = "nix run nixpkgs#goku";
    };

    ".config/kitty/themes/Nord Light.conf" = {
      source = ../dotfiles/nord-light-theme.kitty.conf;
    };
  } // (if useYabai then {
    ".config/skhd/skhdrc" = {
      source = ../dotfiles/skhdrc;
      onChange = "nix run nixpkgs#killall -- skhd";
    };

    ".config/yabai/yabairc" = {
      source = ../dotfiles/yabairc;
      onChange = "nix run nixpkgs#killall -- yabai";
    };
  } else {});

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs = (import ./programs.nix { pkgs = pkgs; }) // { home-manager.enable = true; };
}
