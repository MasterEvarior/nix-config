{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.swayidle = {
    enable = lib.mkEnableOption "Swayidle";
    lock = {
      command = lib.mkOption {
        example = "${pkgs.swaylock}/bin/swaylock -f";
        type = lib.types.str;
        description = "Command to execute to lock the computer";
      };
      timeout = lib.mkOption {
        default = 300;
        example = 120;
        type = lib.types.int;
        description = "Amount in seconds of inactivity before locking the computer";
      };
    };
    suspend = {
      command = lib.mkOption {
        example = "${pkgs.systemd}/bin/systemctl suspend";
        default = "${pkgs.systemd}/bin/systemctl suspend";
        type = lib.types.str;
        description = "Command to execute to suspend the computer";
      };
      timeout = lib.mkOption {
        default = 360;
        example = 360;
        type = lib.types.int;
        description = "Amount in seconds of inactivity before locking the computer";
      };
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway.swayidle;
    in
    lib.mkIf config.homeModules.desktop.sway.swayidle.enable {
      services.swayidle = {
        enable = true;
        timeouts = [
          {
            timeout = cfg.lock.timeout;
            command = cfg.lock.command;
          }
          {
            timeout = cfg.suspend.timeout;
            command = cfg.suspend.command;
            resumeCommand = ''swaymsg "output * power on"'';
          }
        ];
        events = [
          {
            event = "before-sleep";
            command = cfg.lock.command;
          }
        ];
        extraArgs = [
          "-w"
        ];
      };
    };
}
