{ lib, ... }:

let 
    mapKey = f: attrs: lib.attrsets.concatMapAttrs (name: value: {"${(f name)}" = value;}) attrs;

    linkScripts = scripts: 
        mapKey (name: "scripts/${name}") 
            (lib.attrsets.genAttrs scripts (name: {
                source = ./${name};
                executable = true;
            }));
in
{
    home.file = 
        {
            "scripts/git-stack-scripts" = {
                source = ./git-stack-scripts;
            };
        } // linkScripts [
            "freeport"
            "git-stack"
            "hello"
        ];

    shell.paths = [
        "scripts"
        "scripts/git-stack-scripts"
    ];
}