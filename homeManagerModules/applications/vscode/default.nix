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
      default = "Default High Contrast";
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
      ];
      description = "Which (official) VSCode theme to apply";
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
    naturalLanguageSearch = lib.mkOption {
      default = false;
      example = false;
      type = lib.types.bool;
      description = "Wether to enable natural language search for options. Needs a Microsoft online service.";
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
  };

  config = lib.mkIf config.homeModules.applications.vscode.enable {
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
          vscode-extensions.ms-azuretools.vscode-docker
        ]
        ++ config.homeModules.applications.vscode.additionalExtensions;
      userSettings = lib.mkMerge [
        {
          "workbench.colorTheme" = config.homeModules.applications.vscode.theme;
          "telemetry.telemetryLevel" = config.homeModules.applications.vscode.telemetry;
          "workbench.settings.enableNaturalLanguageSearch" =
            config.homeModules.applications.vscode.naturalLanguageSearch;
          "scm.alwaysShowRepositories" = config.homeModules.applications.vscode.scm.alwaysShowRepositories;
          "scm.experimental.showHistoryGraph" = config.homeModules.applications.vscode.scm.showHistoryGraph;
        }
        config.homeModules.applications.vscode.additionalUserSettings
      ];
      languageSnippets = {
        nix = {
          "Create toggleable configuration" = {
            prefix = [ "tog-conf" ];
            description = "Create toggleable .nix configuration";
            body = [
              "{"
              "\tlib,"
              "\tconfig,"
              "\tpkgs,"
              "\t..."
              "}:"
              ""
              "{"
              "\toptions.\${1|modules,homeModules|}.$2 = {"
              "\t\tenable = lib.mkEnableOption \"$3\";"
              "\t};"
              ""
              "\tconfig = lib.mkIf config.$1.$2.enable {"
              "\t};"
              "}"
            ];
          };
          "Create basic configuration" = {
            prefix = [ "conf" ];
            description = "Create basix .nix configuration";
            body = [
              "{"
              "\tpkgs,"
              "\t..."
              "}:"
              ""
              "{"
              "\t$1"
              "}"
            ];
          };
        };
      };
    };
  };
}
