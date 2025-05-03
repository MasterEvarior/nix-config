{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.modules.desktop.hyprland = {
    enable = lib.mkEnableOption " Hyprland";
    monitors = lib.mkOption {
      default = [ ",preferred,auto,auto" ];
      example = [ ",preferred,auto,auto" ];
      type = lib.types.listOf lib.types.str;
      description = "List of your monitor configuration";
    };
    wallpaper = lib.mkOption {
      default = null;
      example = ./your-wallpaper.gif;
      type = lib.types.nullOr lib.types.path;
      description = "Wallpaper for SWWW to display";
    };
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
      wofi

      # nm-applet
      networkmanagerapplet

      # required packages
      # https://wiki.hyprland.org/0.41.0/Nix/Hyprland-on-NixOS/
      dconf
    ];

    # required see:
    # https://wiki.hyprland.org/0.41.0/Nix/Hyprland-on-NixOS/
    security.polkit.enable = true;

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
