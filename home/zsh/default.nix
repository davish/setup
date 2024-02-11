{ lib, config, ... }:

{
  imports = [
    ./aliases.nix
    ./options.nix
  ];
  programs.zsh = {
    enable = true;

    initExtra = ''
      # Search through history with the prefix that's already typed.
      # https://unix.stackexchange.com/questions/621606/zsh-completion-with-up-and-down-arrows
      autoload -U up-line-or-beginning-search
      autoload -U down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search
    '';
  };
}
