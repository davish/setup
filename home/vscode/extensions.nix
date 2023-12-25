{ pkgs, ... }:

{
    programs.vscode.extensions = [
      pkgs.vscode-extensions.vscodevim.vim
      pkgs.vscode-extensions.bbenoist.nix 
      pkgs.vscode-extensions.vspacecode.vspacecode
      pkgs.vscode-extensions.vspacecode.whichkey
      pkgs.vscode-extensions.astro-build.astro-vscode
      pkgs.vscode-extensions.ocamllabs.ocaml-platform
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "nord-light";
        publisher = "huytd";
        version = "0.1.1";
        # Courtesy of pawalt.
        # Start off with an empty string here, and when you get an error, it will have the actual hash
        # as a base64 encoded string. we want hex encoded. Here's a oneliner:
        # echo "base64 hash here" | nix run nixpkgs#python3 -- -c "import base64; print(base64.decodebytes(input().encode('utf-8')).hex())"
        sha256 = "ab6186de3e63dc22c6174d89effa65cb028b9215269b61a7dcc892566899fb8f";
      }
    ];
}