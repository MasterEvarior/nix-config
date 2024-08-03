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
  };

  config = lib.mkIf config.homeModules.programs.vscode.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs; [
        vscode-extensions.redhat.ansible
        vscode-extensions.jnoortheen.nix-ide
        vscode-extensions.tomoki1207.pdf
      ];
      userSettings = {
        "workbench.colorTheme" = config.homeModules.programs.vscode.theme;
      };
    };
  };
}
