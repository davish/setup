{ pkgs, ... }:

{
  home.file.".config/ghostty/config" = {
    source = ./theme.conf;
  };
}
