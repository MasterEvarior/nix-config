{
  lib,
  osConfig,
  ...
}:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
    ./dunst.nix
  ];

  config = lib.mkIf osConfig.programs.hyprland.enable {
    homeModules.desktop.hyprland.enable = lib.mkDefault true;
    homeModules.desktop.waybar.enable = lib.mkDefault true;
    homeModules.desktop.wofi.enable = lib.mkDefault true;
  };
}
