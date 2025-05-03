{
  lib,
  osConfig,
  ...
}:

{
  imports = [
    ./hyprland
    ./sway
    ./waybar.nix
    ./wofi.nix
    ./dunst.nix
  ];

  config =
    let
      osDesktopConfig = osConfig.modules.desktop;
    in
    lib.mkIf osConfig.programs.hyprland.enable {
      homeModules.desktop.hyprland.enable = lib.mkDefault osDesktopConfig.hyprland.enable;
      homeModules.desktop.sway.enable = osDesktopConfig.sway.enable;
    };
}
