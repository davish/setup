{ pkgs, config, lib, home-manager, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
  emacs = (import ../darwin/emacs.nix) { pkgs = pkgs; };
in
{
  # https://nix-community.github.io/home-manager/options.html
  imports = [
    ./direnv
    ./emacs
    ./git
    ./jujutsu
    ./karabiner
    ./kitty
    ./scripts
    ./skhd
    ./vscode
    ./yabai
    ./zsh
  ];

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
    home.packages = with pkgs;
      [
        tmux
        htop
        jetbrains-mono
        (nerdfonts.override {
          fonts = [ "JetBrainsMono" ];
        })
        nixpkgs-fmt
        nodePackages.typescript-language-server
        nodePackages."@astrojs/language-server"
      ];

    home.sessionVariables = {
      EDITOR = "vim";
    };
  };
}
