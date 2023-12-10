{
    imports = [
        ../home-manager/common.nix
    ];
    
    home.file.".config/skhd/skhdrc" = {
      source = ../dotfiles/skhdrc;
      onChange = "nix run nixpkgs#killall -- skhd";
    };

    home.file.".config/yabai/yabairc" = {
      source = ../dotfiles/yabairc;
      onChange = "nix run nixpkgs#killall -- yabai";
    };
}