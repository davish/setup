{ lib, self, pkgs, ... }:

let
  custom-extension-vsix = import ./custom/extension/derivation.nix {
    inherit self;
    inherit pkgs;
  };
  pname = "davish-custom";
  publisher = "davish";
  custom-extension = pkgs.vscode-utils.buildVscodeExtension
    {
      name = "davish-custom";
      src = "${custom-extension-vsix}/${pname}.zip";
      version = "0.0.1";

      vscodeExtUniqueId = "${publisher}.${pname}";
      vscodeExtPublisher = publisher;
      vscodeExtName = pname;

      meta = {
        description = "Custom code for Davis Haupt";
        homepage = "https://davi.sh";
        license = [ lib.licenses.mit ];
        maintainers = [ ];
        platforms = lib.platforms.all;
      };
    };
in
{
  programs.vscode.extensions = with pkgs.vscode-extensions;
    [
      astro-build.astro-vscode
      bbenoist.nix
      esbenp.prettier-vscode
      ocamllabs.ocaml-platform
      usernamehw.errorlens
      vscodevim.vim
      vspacecode.vspacecode
      vspacecode.whichkey
      custom-extension
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nord-light";
        publisher = "huytd";
        version = "0.1.1";
        # Courtesy of pawalt.
        # Start off with lib.fakeHash here, and when you get an error, it will have the actual hash
        # as a base64 encoded string. we want hex encoded. The nix cli has a utility for this:
        # `nix hash to-base16 --type sha256 "sha256-<hash here>"`
        sha256 = "ab6186de3e63dc22c6174d89effa65cb028b9215269b61a7dcc892566899fb8f";
      }
      {
        name = "vscode-todo-highlight";
        publisher = "wayou";
        version = "1.0.5";
        sha256 = "09056d31db7f7d970d21b1ff2b26c98b19cba82b33e6217553493e19f2fae4e9";
      }
      {
        name = "vscode-typescript-next";
        publisher = "ms-vscode";
        version = "5.4.20240105";
        sha256 = "aa27c28798bcac807b4f047a3b06454b17ce44807c0378ca8137eb9f00be828d";
      }
      {
        name = "nixpkgs-fmt";
        publisher = "b4dm4n";
        version = "0.0.1";
        sha256 = "bf3da4537e81d7190b722d90c0ba65fd204485f49696d203275afb4a8ac772bf";
      }
    ];
  # ] ++ [
  #   pkgs.vscode-utils.buildVscodeMarketplaceExtension
  #   {
  #     mktplcRef = {
  #       name = "custom";
  #       publisher = "davish";
  #       version = "0.0.1";
  #       sha256 = lib.fakeHash;
  #     };
  #     vsix = "${custom-extension}/davish-custom.vsix";
  #   }
  # ];
}
