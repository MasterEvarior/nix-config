{
  lib,
  config,
  osConfig,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./waybar.nix
  ];

  config = lib.mkIf osConfig.programs.hyprland.enable {
    homeModules.desktop.hyprland.enable = lib.mkDefault true;
    homeModules.desktop.hyprpaper.enable = lib.mkDefault true;
    homeModules.desktop.waybar.enable = lib.mkDefault true;
  };
}
