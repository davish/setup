{ pkgs, ... }: 

let 
    homebrewConfig = import ./homebrew.nix;
in
{
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    environment.systemPackages =
    [ pkgs.vim ];

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    services.karabiner-elements.enable = true;

    services.yabai.enable = true;
    services.skhd.enable = true;

    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";
    nixpkgs.config.allowUnfree = true;

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh.enable = true;  # default shell on catalina
    # programs.fish.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;

    system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
    system.defaults.dock.autohide = true;

    system.defaults.NSGlobalDomain.InitialKeyRepeat = 20;
    system.defaults.NSGlobalDomain.KeyRepeat = 2;

    nixpkgs.hostPlatform = "aarch64-darwin";

    users.users.davish = {
        name = "davish";
        home = "/Users/davish";
    };
    
    homebrew = import ./homebrew.nix // { enable = true; };
}
