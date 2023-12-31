{ ... }:

{
    programs.vscode.userSettings = {
      "workbench.activityBar.location" = "hidden";
      "files.autoSave" = "onFocusChange";

      "workbench.colorTheme" = "Nord Light";
      "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "editor.accessibilitySupport" = "off";
      "editor.formatOnSave" = true;

      "vim.easymotion" = true;
      "vim.useSystemClipboard" = true;

      # slim down scroll + map ui (from pawalt)
      "editor.minimap.enabled" = false;
      "editor.hideCursorInOverviewRuler" = true;
      "editor.overviewRulerBorder" = false;

      # show compact single tabs with bread crumbs (from pawalt)
      "workbench.editor.showTabs" = "single";
      "window.density.editorTabHeight" = "compact";
      "workbench.editor.tabSizingFixedMinWidth" = 100;
      "breadcrumbs.enabled" = true;
    };
}