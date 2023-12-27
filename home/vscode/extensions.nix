{ pkgs, ... }:

{
    programs.vscode.extensions = with pkgs.vscode-extensions; [
      astro-build.astro-vscode
      bbenoist.nix 
      ocamllabs.ocaml-platform
      usernamehw.errorlens
      vscodevim.vim
      vspacecode.vspacecode
      vspacecode.whichkey
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
        {
            name = "vscode-todo-highlight";
            publisher = "wayou";
            version = "1.0.5";
            sha256 = "09056d31db7f7d970d21b1ff2b26c98b19cba82b33e6217553493e19f2fae4e9";
      }
    ];
}