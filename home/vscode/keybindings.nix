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
        "vim.visualModeKeyBindingsNonRecursive" = [
          vSpaceCodeLaunch
          vSpaceCodeMajorMode
          {
            before = [ "s" ];
            after = [ "S" ];
          }
        ];

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
            "keys" = "t";
            "name" = "Toggle..";
            "type" = "bindings";
            "bindings" = [
              {
                "key" = "t";
                "name" = "Toggle Terminal";
                "type" = "command";
                "command" = "workbench.action.terminal.toggleTerminal";
              }
              {
                "key" = "b";
                "name" = "Toggle Sidebar";
                "type" = "command";
                "command" = "workbench.action.toggleSidebarVisibility";
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

