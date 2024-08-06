{ lib, ... }:

{

  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./waybar.nix
  ];
  homeModules.desktop.hyprland.enable = lib.mkDefault true;
  homeModules.desktop.hyprpaper.enable = lib.mkDefault true;
  homeModules.desktop.waybar.enable = lib.mkDefault true;
}
