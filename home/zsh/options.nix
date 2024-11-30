{ lib, config, ... }:

{
  options = {
    shell.executablePaths = lib.mkOption {
      # description = "paths relative to $HOME to be added to $PATH.";
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };

    programs.zsh.shellFunctions = lib.mkOption {
      # description = "Define functions that will be active in your shell config. Unlike aliases, functions *can* take arguments like $1";
      type = lib.types.attrs;
      default = { };
    };
  };

  config = {
    programs.zsh = {
      envExtra =
        let
          makeShellFunctions = functions: lib.strings.concatStrings
            (lib.attrsets.mapAttrsToList
              (name: value:
                let
                  prettyValue = builtins.concatStringsSep "\n" (
                    map (line: "  ${line}") (lib.strings.splitString "\n" value)
                  );
                in
                "function ${name}() {\n${prettyValue}\n}\n")
              functions);
          addPaths = lib.strings.concatMapStrings (p: "export PATH=$PATH:$HOME/${p}\n");
        in
        makeShellFunctions config.programs.zsh.shellFunctions
        + addPaths config.shell.executablePaths;
    };
  };
}
