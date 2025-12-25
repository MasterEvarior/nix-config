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
      emptyConfig = ''
        search_shortcut: off
        search_trigger: off
      '';
    in
    lib.mkIf osConfig.services.espanso.enable {

      assertions = [
        {
          assertion = osConfig.services.espanso.enable;
          message = "Espanso service needs to be enabled at OS level for the home manager module to work";
        }
      ];

      home.file.".config/espanso/config/default.yaml".text =
        if cfg.enable then
          ''
            search_shortcut: ${cfg.searchShortcut}
            search_trigger: "${cfg.searchTrigger}"
            keyboard_layout:
              layout: "${cfg.keyboardLayout}"
              variant: "${cfg.keyboardVariant}"
          ''
        else
          emptyConfig;
    };
}
