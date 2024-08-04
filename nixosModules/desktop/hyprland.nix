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
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

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

    environment.sessionVariables = {
      # hint Electron applications to use Wayland
      NIXOS_OZONE_WL = "1";
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
