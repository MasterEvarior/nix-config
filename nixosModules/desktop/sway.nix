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
    wayDisplayConfig = lib.mkOption {
      default = null;
      example = ''
        ARRANGE: ROW
        ALIGN: TOP
        ...
      '';
      type = lib.types.nullOr lib.types.str;
      description = "";
    };
    workspaceAssignments = lib.mkOption {
      default = [ ];
      type = lib.types.listOf (
        lib.types.submodule {
          options = {
            outputName = lib.mkOption {
              example = "eDP-1";
              type = lib.types.str;
              description = "Name of the output you want to assign the workspaces too";
            };
            workspace = lib.mkOption {
              example = 1;
              type = lib.types.int;
              description = "Workspace you want to assign to this output";
            };
          };
        }
      );
      description = "Assign particular workspaces to selected outputs";
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

        # Display Management
        way-displays
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

      environment.etc = lib.mkIf (cfg.wayDisplayConfig != null) {
        "way-displays/cfg.yaml" = {
          text = cfg.wayDisplayConfig;
        };
      };

      # systemd.services = {
      #   way-displays-daemon = {
      #     description = "Start way-display and keep it running";
      #     wantedBy = [ "multi-user.target" ];
      #     script = ''
      #       ${pkgs.way-displays}/bin/way-displays;
      #     '';
      #     serviceConfig = {
      #       Restart = "always";
      #     };
      #     environment = {
      #       WAYLAND_DISPLAY = "wayland-1"; # hacky fix, lets see if this works out
      #     };
      #   };
      # };

      environment.sessionVariables = { } // hardwareCursor;

      security.pam.services.swaylock = { };

      # Enable the gnome-keyring secrets vault.
      # Will be exposed through DBus to programs willing to store secrets.
      services.gnome.gnome-keyring.enable = true;

      # required per the wiki
      security.polkit.enable = true;
    };
}
