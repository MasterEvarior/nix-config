{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.applications.gemini-cli = {
    enable = lib.mkEnableOption "Gemini CLI";
    hideTips = lib.mkEnableOption "Wether or not to hide tips";
    telemetry = lib.mkEnableOption "Wether or not to enable telemetry";
    theme = lib.mkOption {
      default = "Default";
      example = "Default";
      type = lib.types.enum [
        "ANSI"
        "Atom One"
        "Ayu"
        "Default"
        "Dracula"
        "GitHub"
        "ANSI Light"
        "Ayu Light"
        "Default Light"
        "GitHub Light"
        "Google Code"
        "Xcode"
      ];
      description = "Which theme to apply";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.gemini-cli;
    in
    lib.mkIf config.homeModules.applications.gemini-cli.enable {
      home.packages = with pkgs-unstable; [
        gemini-cli
      ];

      home.file.".gemini/settings.json".text = ''
        {
          "theme": "GitHub",
          "telemetry": {
            "enabled": ${toString cfg.telemetry}
          },
          "usageStatisticsEnabled": ${toString cfg.telemetry},
          "hideTips": ${toString cfg.hideTips}
        }
      '';
    };
}
