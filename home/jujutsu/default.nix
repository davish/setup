{ ... }:

{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "Davis Haupt";
        email = "me@davishaupt.com";
      };

      ui.diff.tool = [ "difft" "--color=always" "$left" "$right" ];
    };
  };
}
