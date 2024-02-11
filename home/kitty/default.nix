{ pkgs, ... }:

{
  home.file.".config/kitty/themes/Nord Light.conf" = {
    source = ./nord-light-theme.kitty.conf;
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    font.name = "JetBrains Mono";

    # The kitty.themes setting doesn't support custom themes, 
    # so just include the config.
    extraConfig = ''
      include themes/Nord Light.conf
    '';
  };
}
