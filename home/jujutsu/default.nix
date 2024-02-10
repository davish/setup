{ ... }:

{
    programs.jujutsu = {
        enable = true;
        enableZshIntegration = true;
        settings = {
            user = {
                name = "Davis Haupt";
                email = "me@davishaupt.com";
            };

            ui.diff.tool = ["difft" "--color=always" "$left" "$right"];
        };
    };
}