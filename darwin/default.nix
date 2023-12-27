{ pkgs, config, ... }: 

let my-emacs = (import ./emacs.nix {pkgs = pkgs;}); in
{
    environment.systemPackages = with pkgs; [ 
        binutils # native-comp needs 'as', provided by this

        my-emacs

        ## Doom dependencies not covered above
        (ripgrep.override {withPCRE2 = true;})
        gnutls # for TLS connectivity

    ];

    homebrew = import ./homebrew.nix // { enable = true; };

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    services.karabiner-elements.enable = true;

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

    system.defaults.CustomUserPreferences = {
        # "com.google.Chrome" = {
        #     "NSUserKeyEquivalents" = {
        #         "Open Location..." = "@d";
        #     };
        # };
    };

    services.skhd.enable = true;
    # system.keyboard.userKeyMapping = [
    #     # caps lock to escape
    #     {
    #         HIDKeyboardModifierMappingSrc = 30064771129; 
    #         HIDKeyboardModifierMappingDst = 30064771113;
    #     }
    #     # 
    # ]
}
