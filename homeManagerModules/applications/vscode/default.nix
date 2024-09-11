{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.homeModules.programs.vscode = {
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
  };

  config = lib.mkIf config.homeModules.programs.vscode.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;
      extensions = with pkgs; [
        # Angular/JS/TS
        vscode-extensions.angular.ng-template
        vscode-extensions.esbenp.prettier-vscode
        vscode-extensions.dbaeumer.vscode-eslint
        vscode-extensions.usernamehw.errorlens

        # Ansible
        vscode-extensions.redhat.ansible
        vscode-extensions.ms-python.python # is needed for the ansible extension
        vscode-extensions.redhat.vscode-yaml # is needed for the ansible extension

        # Nix
        vscode-extensions.jnoortheen.nix-ide

        # Div
        vscode-extensions.tomoki1207.pdf
        vscode-extensions.ms-azuretools.vscode-docker
      ];
      userSettings = {
        "workbench.colorTheme" = config.homeModules.programs.vscode.theme;
        "telemetry.telemetryLevel" = config.homeModules.programs.vscode.telemetry;
        "workbench.settings.enableNaturalLanguageSearch" =
          config.homeModules.programs.vscode.naturalLanguageSearch;
        "scm.alwaysShowRepositories" = config.homeModules.programs.vscode.scm.alwaysShowRepositories;
        "scm.experimental.showHistoryGraph" = config.homeModules.programs.vscode.scm.showHistoryGraph;
      };
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
