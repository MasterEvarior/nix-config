{
  lib,
  config,
  pkgs,
  ...
}:

let
  updateScript = lib.getExe (
    pkgs.writeShellApplication {
      name = "comma-update-script.sh";
      runtimeInputs = with pkgs; [
        libnotify
        nix
      ];
      text = (builtins.readFile ./assets/update-script.sh);
    }
  );
in
{
  options.homeModules.applications.comma = {
    enable = lib.mkEnableOption "Comma";
    autoUpdateDatabase = lib.mkOption {
      default = true;
      example = false;
      description = "Whether to auto update the nix-index database";
      type = lib.types.bool;
    };
  };

  config = lib.mkIf config.homeModules.applications.comma.enable {
    home.packages = with pkgs; [
      comma
    ];

    systemd.user = lib.mkIf config.homeModules.applications.comma.autoUpdateDatabase {
      services.comma-auto-update = {
        Unit = {
          Description = "Automatically update the database for comma";
        };

        Service = {
          ExecStart = updateScript;
        };
      };

      timers.comma-auto-update = {
        Unit = {
          Description = "Automatically update the database for comma";
        };

        Timer = {
          OnCalendar = "monthly";
          Persistent = true;
        };

        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
  };
}
