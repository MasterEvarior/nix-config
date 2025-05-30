{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.flex-launcher = {
    enable = lib.mkEnableOption "Flex Launcher";
    autostart = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to autostart the application";
    };
    config = lib.mkOption {
      example = ''
        [Section]
        Key1=value
        Key2=value
      '';
      type = lib.types.str;
      description = "https://github.com/complexlogic/flex-launcher/blob/master/docs/configuration.md";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.flex-launcher;
    in
    lib.mkIf config.homeModules.applications.flex-launcher.enable {
      home.packages = with pkgs; [
        flex-launcher
      ];

      home.file.".config/autostart/flex-launcher.desktop".text = lib.mkIf cfg.autostart ''
        [Desktop Entry]
        Version=1.5
        Type=Application
        Name=Flex Launcher
        GenericName=Application Launcher
        Comment=Customizable HTPC Application Launcher
        TryExec=${pkgs.flex-launcher}/bin/flex-launcher
        Exec=${pkgs.flex-launcher}/bin/flex-launcher
        Categories=Video;AudioVideo;
        X-GNOME-Autostart-enabled=true
        X-GNOME-Autostart-Delay=0
      '';
      home.file.".config/flex-launcher/config.ini".text = cfg.config;
    };
}
