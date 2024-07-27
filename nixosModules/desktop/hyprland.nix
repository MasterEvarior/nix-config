{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.desktop.hyprland = {
    enable = lib.mkEnableOption " Hyprland";
  };

  config = lib.mkIf config.modules.desktop.hyprland.enable {
    # Most of this comes from this execellent vimjoyer video
    # https://www.youtube.com/watch?v=61wGzIv12Ds
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      waybar

      # notification daemon
      dunst
      libnotify

      # wallpaper daemon
      swww

      # app launcher
      rofi-wayland

      # default terminal of wayland
      kitty
    ];

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
