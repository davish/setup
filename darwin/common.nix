{ pkgs, ... }: 

let
    my-emacs = pkgs.emacs29.override {
        withNativeCompilation = true;
        withSQLite3 = true;
        withTreeSitter = true;
        withWebP = true;
    };
    my-emacs-patched = my-emacs.overrideAttrs(old: {
        patches =
          (old.patches or [])
          ++ [
            # Don't raise another frame when closing a frame
            (pkgs.fetchpatch {
              url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-28/no-frame-refocus-cocoa.patch";
              sha256 = "QLGplGoRpM4qgrIAJIbVJJsa4xj34axwT3LiWt++j/c=";
            })
            # Fix OS window role so that yabai can pick up Emacs
            (pkgs.fetchpatch {
              url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-28/fix-window-role.patch";
              sha256 = "+z/KfsBm1lvZTZNiMbxzXQGRTjkCFO4QPlEK35upjsE=";
            })
            # Use poll instead of select to get file descriptors
            (pkgs.fetchpatch {
              url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-29/poll.patch";
              sha256 = "jN9MlD8/ZrnLuP2/HUXXEVVd6A+aRZNYFdZF8ReJGfY=";
            })
            # Add setting to enable rounded window with no decoration (still
            # have to alter default-frame-alist)
            (pkgs.fetchpatch {
              url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-30/round-undecorated-frame.patch";
              sha256 = "uYIxNTyfbprx5mCqMNFVrBcLeo+8e21qmBE3lpcnd+4=";
            })
            # Make Emacs aware of OS-level light/dark mode
            # https://github.com/d12frosted/homebrew-emacs-plus#system-appearance-change
            (pkgs.fetchpatch {
              url = "https://raw.githubusercontent.com/d12frosted/homebrew-emacs-plus/master/patches/emacs-28/system-appearance.patch";
              sha256 = "oM6fXdXCWVcBnNrzXmF0ZMdp8j0pzkLE66WteeCutv8=";
            })
          ];
      });
    my-emacs-with-packages = (pkgs.emacsPackagesFor my-emacs-patched).emacsWithPackages (epkgs: with epkgs; [
        pkgs.mu
        vterm
        multi-vterm
        pdf-tools
        treesit-grammars.with-all-grammars
    ]);
in {
    environment.systemPackages = with pkgs; [ 
        binutils # native-comp needs 'as', provided by this

        my-emacs-with-packages

        ## Doom dependencies not covered above
        (ripgrep.override {withPCRE2 = true;})
        gnutls # for TLS connectivity
    ];

    homebrew = import ./homebrew.nix // { enable = true; };

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    services.karabiner-elements.enable = true;

    services.emacs = {
        enable = true;
        package = my-emacs-with-packages;
    };

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
        "com.google.Chrome" = {
            "NSUserKeyEquivalents" = {
                "Open Location..." = "@d";
            };
        };
    };
    
}
