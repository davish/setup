{ ... }:

{
    home.file."scripts" = {
        source = ./scripts;
    };

    shell.paths = [
        "scripts"
        "scripts/git-stack-scripts"
    ];
}