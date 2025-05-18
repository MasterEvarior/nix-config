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
    useSwaylock = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Wether or not enable Swaylock";
    };
    disableHardwareCursor = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to disable the hardware cursor. May help with SwayFX if the cursor is invisible.";
    };
    enableUnsupportedGPU = lib.mkEnableOption "Add --unsupported-gpu option to sway";
    focusOnStartup = lib.mkOption {
      default = null;
      example = "AOC 24G2W1G4 ATNN11A013004";
      type = lib.types.nullOr lib.types.str;
      description = "Output to focus on after startup";
    };
  };

  config =
    let
      cfg = config.modules.desktop.sway;
      package = if cfg.useSwayFX then pkgs.swayfx else pkgs.sway;
      hardwareCursor = if cfg.disableHardwareCursor then { WLR_NO_HARDWARE_CURSORS = "1"; } else { };
      extraOptions = if cfg.enableUnsupportedGPU then [ "--unsupported-gpu" ] else [ ];
    in
    lib.mkIf config.modules.desktop.sway.enable {
      environment.systemPackages = with pkgs; [
        wl-clipboard
        pulseaudio
      ];

      fonts.packages = with pkgs; [
        # Waybar
        font-awesome
        roboto
        roboto-mono
      ];

      services.blueman.enable = true;

      programs = {
        sway = {
          enable = true;
          xwayland.enable = true;
          wrapperFeatures.gtk = true;
          package = package;
          extraOptions = extraOptions;
        };
      };

      environment.sessionVariables = { } // hardwareCursor;

      security.pam.services.swaylock = { };

      # Enable the gnome-keyring secrets vault.
      # Will be exposed through DBus to programs willing to store secrets.
      services.gnome.gnome-keyring.enable = true;

      # required per the wiki
      security.polkit.enable = true;
    };
}
