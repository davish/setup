{ lib, ... }:

let 
    mapKeys = f: attrs: lib.attrsets.concatMapAttrs (name: value: {"${(f name)}" = value;}) attrs;

    linkScripts = scripts: 
        mapKeys (name: "scripts/${name}") 
            (lib.attrsets.genAttrs scripts (name: {
                source = ./${name};
                executable = true;
            }));
in
{
    home.file = linkScripts [
        "freeport"
        "git-stack"
        "hello"
    ] // {
        "scripts/git-stack-scripts" = {
            source = ./git-stack-scripts;
        };
    };

    shell.paths = [
        "scripts"
        "scripts/git-stack-scripts"
    ];
}