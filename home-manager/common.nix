{ pkgs, config, lib, home-manager, ... }:

let 
  isDarwin = pkgs.stdenv.isDarwin;
  emacs = (import ../darwin/emacs.nix) { pkgs = pkgs; };
in
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
    ".config/kitty/themes/Nord Light.conf" = {
      source = ../dotfiles/nord-light-theme.kitty.conf;
    };

    ".doom.d" = {
      source = ../dotfiles/doom;
      onChange = "${emacs}/bin/emacsclient -e '(doom/reload)'";
    };

    # "/Applications/Emacs.app" = {
    #   source = /usr/local/opt/emacs-mac/Emacs.app;
    # };
  } // (if isDarwin then {
    ".config/karabiner.edn" = {
      source = ../dotfiles/karabiner.edn;
      onChange = "nix run nixpkgs#goku";
    };
  } else {});

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs = (import ./programs.nix { pkgs = pkgs; }) // { home-manager.enable = true; };

  home.activation.install-doom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if ! [ -d "$HOME/.emacs.d" ]; then
      $DRY_RUN_CMD ${
        lib.getExe pkgs.git
      } clone $VERBOSE_ARG --depth=1 --single-branch "https://github.com/doomemacs/doomemacs.git" "$HOME/.emacs.d";
    fi
  '';
}
