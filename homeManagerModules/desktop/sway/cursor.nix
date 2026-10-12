{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.cursor = {
    enable = lib.mkEnableOption "Cursor";
  };

  config = lib.mkIf config.homeModules.desktop.sway.cursor.enable {
    home.pointerCursor = {
      enable = true;
      package = pkgs.catppuccin-cursors.macchiatoDark;
      name = "catppuccin-macchiato-dark-cursors";
      sway = {
        enable = true;
        size = 20;
      };
    };
  };
}
