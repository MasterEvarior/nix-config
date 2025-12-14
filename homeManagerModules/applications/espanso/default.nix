{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:

{
  options.homeModules.applications.espanso = {
    enable = lib.mkEnableOption "A Privacy-first, Cross-platform Text Expander";
    package = lib.mkPackageOption pkgs "espanso-wayland" { };
    searchShortcut = lib.mkOption {
      default = "off";
      example = "ALT+SHIFT+SPACE";
      type = lib.types.str;
      description = "https://espanso.org/docs/configuration/options/#customizing-the-search-shortcut";
    };
    searchTrigger = lib.mkOption {
      default = ".search";
      example = ".search";
      type = lib.types.str;
      description = "https://espanso.org/docs/configuration/options/#customizing-the-search-trigger";
    };
    keyboardLayout = lib.mkOption {
      default = "ch";
      example = "ch";
      type = lib.types.str;
      description = "https://espanso.org/docs/install/linux/#terra-wayland";
    };
    keyboardVariant = lib.mkOption {
      default = "de_nodeadkeys";
      example = "de_nodeadkeys";
      type = lib.types.str;
      description = "https://espanso.org/docs/install/linux/#terra-wayland";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.espanso;
    in
    lib.mkIf config.homeModules.applications.espanso.enable {
      home.packages = [
        cfg.package
      ];

      assertions = [
        {
          assertion = osConfig.services.espanso.enable;
          message = "Espanso service needs to be enabled at OS level for the home manager module to work";
        }
      ];

      home.file.".config/espanso/config/default.yaml".text = ''
        search_shortcut: ${cfg.searchShortcut}
        search_trigger: "${cfg.searchTrigger}"
        keyboard_layout:
          layout: "${cfg.keyboardLayout}"
          variant: "${cfg.keyboardVariant}"
      '';

      homeModules.desktop.sway.additionalStartupCommands = [
        {
          command = "${lib.getExe cfg.package} --unmanaged";
          always = false;
        }
      ];
    };
}
