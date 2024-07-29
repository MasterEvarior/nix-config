{ lib, ... }:

{

  imports = [ ./hyprland.nix ];
  homeModules.desktop.hyprland.enable = lib.mkDefault true;
}
