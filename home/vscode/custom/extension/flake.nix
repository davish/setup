{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      defaultPackage."aarch64-darwin" = pkgs.stdenv.mkDerivation
        {
          name = "custom-vscode-extension";
          src = ./.;
          buildInputs = with pkgs; [
            esbuild
            nodejs_20
          ];
          installPhase = ''
            mkdir $out
            ${pkgs.vsce}/bin/vsce package --allow-missing-repository -o davish-custom.zip
            cp davish-custom.zip $out/davish-custom.zip
          '';
        };
    };
}
