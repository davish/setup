{ pkgs, ... }:

pkgs.stdenv.mkDerivation
{
  name = "custom-vscode-extension";
  src = ./.;
  nativeBuildInputs = with pkgs; [
    jq
    moreutils
    esbuild
    # Required by `keytar`, which is a dependency of `vsce`.
    pkg-config
    libsecret
    nodejs_20
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.AppKit
    darwin.apple_sdk.frameworks.Security
  ];

  installPhase = ''
    mkdir -p $out
    mkdir -p logs
    mkdir -p cache
    export npm_config_logs_dir=./logs
    export npm_config_loglevel=verbose
    export npm_config_cache=./cache
    ${pkgs.vsce}/bin/vsce package --allow-missing-repository -o davish-custom.zip
    cp davish-custom.zip $out/davish-custom.zip
  '';
}

