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
    useSwayFX = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Use SwayFX instead of Sway";
    };
  };

  config =
    let
      cfg = config.modules.desktop.sway;
      package = if cfg.useSwayFX then pkgs.sway else pkgs.swayfx;
    in
    lib.mkIf config.modules.desktop.sway.enable {
      environment.systemPackages = with pkgs; [
        wl-clipboard
        pulseaudio
      ];

      programs.sway = {
        enable = true;
        xwayland.enable = true;
        wrapperFeatures.gtk = true;
        package = package;
      };

      # Enable the gnome-keyring secrets vault.
      # Will be exposed through DBus to programs willing to store secrets.
      services.gnome.gnome-keyring.enable = true;

      # required per the wiki
      security.polkit.enable = true;
    };
}
