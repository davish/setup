{ ... }:

{
  programs.vscode = {
    userSettings =
      let
        vSpaceCodeLaunch = {
          "before" = [ "<space>" ];
          "commands" = [ "vspacecode.space" ];
        };
        vSpaceCodeMajorMode = {
          "before" = [ "," ];
          "commands" = [
            "vspacecode.space"
            {
              "command" = "whichkey.triggerKey";
              "args" = "m";
            }
          ];
        };
      in
      {
        "vim.normalModeKeyBindingsNonRecursive" = [ vSpaceCodeLaunch vSpaceCodeMajorMode ];
        "vim.visualModeKeyBindingsNonRecursive" = [ vSpaceCodeLaunch vSpaceCodeMajorMode ];

        "vspacecode.bindingOverrides" = [
          {
            "keys" = "f.f";
            "name" = "Open file";
            "type" = "command";
            "command" = "workbench.action.quickOpen";
          }
          {
            "keys" = "b.b";
            "name" = "Switch buffers";
            "type" = "command";
            "command" = "workbench.action.showEditorsInActiveGroup";
          }
          {
            "keys" = "o";
            "name" = "Open Application...";
            "type" = "bindings";
            "bindings" = [
              {
                "key" = "t";
                "name" = "Open Terminal";
                "type" = "command";
                "command" = "workbench.action.terminal.toggleTerminal";
              }
            ];
          }
        ];
      };

    keybindings = [
      {
        key = "space";
        command = "vspacecode.space";
        when = "((activeEditorGroupEmpty && focusedView == '') || sideBarFocus) && !whichkeyActive && !inputFocus";
      }
      {
        key = "shift+cmd+j";
        command = "workbench.action.focusActiveEditorGroup";
        when = "terminalFocus";
      }
      {
        key = "shift+cmd+'";
        command = "workbench.action.terminal.toggleTerminal";
        when = "terminalFocus";
      }
    ];
  };
}
