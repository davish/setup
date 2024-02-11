{ lib, config, ... }:

{
    options = {
        shell.paths = lib.mkOption {
            type = lib.types.listOf lib.types.str;
            default = [ ];
        };

        programs.zsh.shellFunctions = lib.mkOption {
            type = lib.types.attrs;
            default = {};
        };
    };

    config = {
        programs.zsh = {
            envExtra = 
                let 
                    makeShellFunctions = functions: lib.strings.concatStrings 
                        (lib.attrsets.mapAttrsToList (name: value: "function ${name}() {${value}}\n") functions);
                    addPaths = lib.strings.concatMapStrings (p: "export PATH=$PATH:$HOME/${p}\n"); 
                in
            makeShellFunctions config.programs.zsh.shellFunctions
            + addPaths config.shell.paths;
        };
    };
}