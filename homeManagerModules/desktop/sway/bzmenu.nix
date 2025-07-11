{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.desktop.sway.bzmenu = {
    enable = lib.mkEnableOption "Launcher-driven Bluetooth manager for Linux ";
    launcher = lib.mkOption {
      example = "fuzzel";
      type = lib.types.str;
      description = "Which launcher to use";
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway.bzmenu;
      pkg = pkgs-unstable.bzmenu;
    in
    lib.mkIf config.homeModules.desktop.sway.bzmenu.enable {
      home.packages = [
        pkg
      ];

      homeModules.desktop.sway.waybar.bluetoothCommand =
        "${lib.getBin pkg}/bin/bzmenu --launcher ${cfg.launcher}";
    };
}
