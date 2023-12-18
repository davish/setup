{ pkgs, config, lib, home-manager, ... }:

let 
  isDarwin = pkgs.stdenv.isDarwin;
  emacs = (import ../darwin/emacs.nix) { pkgs = pkgs; };
in
{
  imports = [
    ./programs
  ];

  options.services.skhd = {
    enable = lib.mkEnableOption "skhd configuration";
    components = lib.mkOption {
      type = lib.types.listOf lib.types.path;
      default = [ ];
    };
  };
  config = {
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

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    fonts.fontconfig.enable = true;

    # The home.packages option allows you to install Nix packages into your
    # environment.
    home.packages = with pkgs; [
      tmux
      htop
      jetbrains-mono
      (nerdfonts.override {fonts = [ "JetBrainsMono"]; })
      nodePackages.typescript-language-server
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    home.file = {
      ".config/kitty/themes/Nord Light.conf" = {
        source = ../dotfiles/nord-light-theme.kitty.conf;
      };

      ".doom.d" = {
        source = ../dotfiles/doom;
      };

      ".config/skhd/skhdrc" = lib.mkIf config.services.skhd.enable {
        text = lib.strings.concatStrings (lib.strings.intersperse "\n" (map builtins.readFile config.services.skhd.components));
        onChange = "${pkgs.killall}/bin/killall skhd";
      };
    } // (if isDarwin then {
      ".config/karabiner.edn" = {
        source = ../dotfiles/karabiner.edn;
        onChange = "${pkgs.goku}/bin/goku";
      };

    } else {});

    home.sessionVariables = {
      EDITOR = "vim";
    };

    home.activation.install-doom = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      if ! [ -d "$HOME/.emacs.d" ]; then
        $DRY_RUN_CMD ${
          lib.getExe pkgs.git
        } clone $VERBOSE_ARG --depth=1 --single-branch "https://github.com/doomemacs/doomemacs.git" "$HOME/.emacs.d";
      fi
    '';
  };
}
