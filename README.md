# My Nix Setup

This is my Nix configuration! It's pretty bare-bones at this point, and not particularly reusable. Right now it's running on one Mac Mini.

I'm using:
- [`nix-darwin`](https://github.com/LnL7/nix-darwin) to manage system-wide settings and applications.
- [`home-manager`](https://github.com/nix-community/home-manager) to manage user-level configuration and dotfiles.

I'm also using Nix flakes -- I wish I knew enough about Nix to explain exactly what they are and why they're special.

Dotfiles for specific applications can be found in the `dotfiles/` folder.