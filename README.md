# My Nix Setup

This is my Nix configuration!

I'm using:
- [`nix-darwin`](https://github.com/LnL7/nix-darwin) to manage system-wide settings and applications.
- [`home-manager`](https://github.com/nix-community/home-manager) to manage user-level configuration and dotfiles.

I haven't configured any NixOS systems yet, but my goal is to keep macOS-specific configuration, such as the Emacs distribution I'm using, at the nix-darwin level, so that home-manager can be shared as much as possible accross platforms.

I'm also using Nix flakes -- I wish I knew enough about Nix to explain exactly what they are and why they're special.

## Layout

I make pretty heavy use of [Nix modules](https://nixos.wiki/wiki/NixOS_modules) in this config. 
In every directory, `default.nix` is the entrypoint.

- `nix-darwin` default configuration lives in `darwin/`
- `home-manager` default configuration lives in `home/`
- host-specific overrides and functionality live in the `hosts/` directory. 
  Each host has a `configuration.nix` file for system config and a `home.nix` 
  file for home-manager.
- dotfiles for specific applications can be found in directories under `home/` alongside their home-manager configuration.

## Inspiration
- [noctuid's emacs patches](https://github.com/noctuid/dotfiles/blob/master/nix/overlays/emacs.nix)
- [mitchellh's general layout](https://github.com/mitchellh/nixos-config)
- [pawalt for collaboration](https://github.com/pawalt/setup)
