{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.desktop.sway = {
    enable = lib.mkEnableOption "Sway";
    outputs = lib.mkOption {
      default = { };
      example = {
        HDMI-A-2 = {
          bg = "~/path/to/background.png fill";
        };
      };
      type = lib.types.attrs;
      description = "An attribute set that defines output modules. See sway-output(5) for options.";
    };
  };

  config = lib.mkIf config.modules.desktop.sway.enable {
    environment.systemPackages = with pkgs; [ wl-clipboard ];

    programs.sway = {
      enable = true;
      xwayland.enable = true;
      wrapperFeatures.gtk = true;
    };

    # Enable the gnome-keyring secrets vault.
    # Will be exposed through DBus to programs willing to store secrets.
    services.gnome.gnome-keyring.enable = true;

    # required per the wiki
    security.polkit.enable = true;
  };
}
