{ lib, config, ... }:

let
  types = lib.types;
in
{
  options.homeModules.desktop.hyprpaper = {
    enable = lib.mkEnableOption "Hyprpaper customization";
    wallpaper = lib.mkOption {
      default = ./assets/wallpappers/wallpaper-cherry-tree-beach.png; # TODO: parameterized this for real
      example = ./your-wallpaper.png;
      type = types.path;
      description = "Wallpaper you want to set";
    };
  };
  config = lib.mkIf config.homeModules.desktop.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;

        preload = builtins.toString config.homeModules.desktop.hyprpaper.wallpaper;
        wallpaper = "eDP-1,${builtins.toString config.homeModules.desktop.hyprpaper.wallpaper}";
      };
    };
  };
}
