{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.plymouth = {
    enable = lib.mkEnableOption "Plymouth Boot Screen";
    theme = lib.mkOption {
      default = "hexagon_dots";
      example = "rings";
      type = lib.types.str;
      description = "Select a theme from here: https://github.com/adi1090x/plymouth-themes/tree/master";
    };
    showBootloader = lib.mkEnableOption "Disable bootloader showing";
  };

  config =
    let
      cfg = config.modules.plymouth;
    in
    lib.mkIf config.modules.plymouth.enable {
      boot = {
        plymouth = {
          enable = true;
          theme = cfg.theme;
          themePackages = with pkgs; [
            # By default we would install all themes
            (adi1090x-plymouth-themes.override {
              selected_themes = [ cfg.theme ];
            })
          ];
        };

        # Enable "Silent boot"
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];

        # Hide the OS choice for bootloaders.
        # It's still possible to open the bootloader list by pressing any key
        # It will just not appear on screen unless a key is pressed
        loader.timeout = lib.mkIf cfg.showBootloader 0;
      };
    };
}
