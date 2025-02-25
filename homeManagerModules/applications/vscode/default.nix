{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.homeModules.applications.vscode = {
    enable = lib.mkEnableOption "Visual Studio Code configuration";
    theme = lib.mkOption {
      default = "Catppuccin Mocha";
      example = "dark";
      type = lib.types.enum [
        "Abyss"
        "Visual Studio Dark"
        "Default High Contrast"
        "Default Modern"
        "Default Dark+"
        "Kimbie Dark"
        "Visual Studio Light"
        "Default Light High Contrast"
        "Default Light Modern"
        "Default Light+"
        "Monokai"
        "Monokai Dimmed"
        "Quiet Light"
        "Red"
        "Solarized Dark"
        "Solarized Light"
        "Tommorow Night Blue"
        "Catppuccin Mocha"
      ];
      description = "Which VSCode theme to apply";
    };
    telemetry = lib.mkOption {
      default = "off";
      example = "off";
      type = lib.types.enum [
        "all"
        "error"
        "crash"
        "off"
      ];
      description = "Change the level of telemetry to send";
    };
    workbench.naturalLanguageSearch = lib.mkOption {
      default = false;
      example = false;
      type = lib.types.bool;
      description = "Wether to enable natural language search for options. Needs a Microsoft online service.";
    };
    workbench.startupEditor = lib.mkOption {
      default = "none";
      example = "none";
      type = lib.types.enum [
        "none"
        "welcomePage"
        "readme"
        "newUntitledFile"
        "welcomePageInEmptyWorkbench"
        "terminal"
      ];
      description = "Controls which editor is shown at startup, if none are restored from the previous session";
    };
    workbench.tipsEnabled = lib.mkOption {
      default = false;
      example = false;
      type = lib.types.bool;
      description = "When enabled, will show the watermark tips when no editor is open";
    };
    scm.alwaysShowRepositories = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether to always show the repository inside the SCM tab";
    };
    scm.showHistoryGraph = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether to a history graph instead of changes inside the SCM tab";
    };

    additionalExtensions = lib.mkOption {
      default = [ ];
      example = [ ];
      type = lib.types.listOf lib.types.package;
      description = "Additional extensions that should be installed";
    };

    additionalUserSettings = lib.mkOption {
      default = { };
      example = { };
      type = lib.types.attrsOf lib.types.anything;
      description = "Additional setting keys that should be set";
    };

    additionalSnippets = lib.mkOption {
      default = { };
      example = { };
      type = lib.types.attrsOf lib.types.anything;
      description = "Additional language snippets";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.vscode;
    in
    lib.mkIf config.homeModules.applications.vscode.enable {
      programs.vscode = {
        enable = true;
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        mutableExtensionsDir = false;
        extensions =
          with pkgs;
          [
            # Div
            vscode-extensions.tomoki1207.pdf
            vscode-extensions.ms-vscode.live-server
            vscode-extensions.tamasfe.even-better-toml

            # Catpuccin Theme
            vscode-extensions.catppuccin.catppuccin-vsc
            vscode-extensions.catppuccin.catppuccin-vsc-icons
          ]
          ++ cfg.additionalExtensions;
        userSettings = lib.mkMerge [
          {
            "workbench.colorTheme" = cfg.theme;
            "telemetry.telemetryLevel" = cfg.telemetry;
            "workbench.settings.enableNaturalLanguageSearch" = cfg.workbench.naturalLanguageSearch;
            "workbench.startupEditor" = cfg.workbench.startupEditor;
            "workbench.tips.enabled" = cfg.workbench.tipsEnabled;
            "scm.alwaysShowRepositories" = cfg.scm.alwaysShowRepositories;
            "extensions.ignoreRecommendations" = true;
            "update.showReleaseNotes" = false;
            "terminal.integrated.fontFamily" = "Hack Nerd Font";
            "git.openRepositoryInParentFolders" = "never";
          }
          cfg.additionalUserSettings
        ];
        languageSnippets = lib.mkMerge [
          { }
          cfg.additionalSnippets
        ];

        keybindings = [
          {
            "key" = "alt+f12";
            "command" = "workbench.action.terminal.toggleTerminal";
            "when" = "terminal.active";
          }
          {
            "key" = "ctrl+shift+[Equal]";
            "command" = "-workbench.action.terminal.toggleTerminal";
            "when" = "terminal.active";
          }
          {
            "key" = "ctrl+w";
            "command" = "editor.action.smartSelect.expand";
            "when" = "editorTextFocus";
          }
          {
            "key" = "shift+alt+right";
            "command" = "-editor.action.smartSelect.expand";
            "when" = "editorTextFocus";
          }
          {
            "key" = "ctrl+d";
            "command" = "editor.action.copyLinesDownAction";
            "when" = "editorTextFocus && !editorReadonly";
          }
          {
            "key" = "ctrl+y";
            "command" = "editor.action.deleteLines";
            "when" = "textInputFocus && !editorReadonly";
          }
        ];
      };
    };
}
