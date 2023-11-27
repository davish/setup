pkgs: {
  extensions = [
    pkgs.vscode-extensions.vscodevim.vim
    pkgs.vscode-extensions.bbenoist.nix 
    pkgs.vscode-extensions.vspacecode.vspacecode
    pkgs.vscode-extensions.vspacecode.whichkey
  ];
  
  userSettings = let vSpaceCodeLaunch = {
      "before" = [ "<space>" ];
      "commands" = [ "vspacecode.space" ];
  }; in {
    "workbench.editor.showTabs" = false;
    "workbench.activityBar.location" = "hidden";
    "files.autoSave" = "onFocusChange";

    "workbench.colorTheme" = "Nord Light";

    "vim.easymotion" = true;
    "vim.useSystemClipboard" = true;
    "vim.normalModeKeyBindingsNonRecursive" = [ vSpaceCodeLaunch ];
    "vim.visualModeKeyBindingsNonRecursive" = [ vSpaceCodeLaunch ];

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
    ];
  };

  keybindings = [
    {
        key = "space";
        command = "vspacecode.space";
        when = "activeEditorGroupEmpty && focusedView == '' && !whichkeyActive && !inputFocus";
    }
  ];
}