{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.backup = {
    enable = lib.mkEnableOption "Backup with Restic";
    name = lib.mkOption {
      default = (config.networking.hostName);
      example = "arrakis";
      type = lib.types.str;
    };
    repository = lib.mkOption {
      default = "";
      example = "rest:https://your-url.example.com";
      type = lib.types.str;
      description = "Wether to a configure the SSH config for the 1Password agent";
    };
    username = lib.mkOption {
      default = "";
      example = "username";
      type = lib.types.str;
    };
    passwordFile = lib.mkOption {
      default = "";
      example = "/etc/restic/yourPwd";
      type = lib.types.str;
    };
    schedule = lib.mkOption {
      default = "daily";
      example = "daily";
      type = lib.types.str;
    };
    paths = lib.mkOption {
      default = [ ];
      example = [ "/home" ];
      type = lib.types.listOf lib.types.str;
    };
    exclude = lib.mkOption {
      default = [
        ".git"
        "/var/cache"
        "/home/*/.cache"
        "/home/*/Documents/GitHub"
        "/home/*/Documents/Github"
      ];
      example = [ ".git" ];
      type = lib.types.listOf lib.types.str;
      description = "See https://restic.readthedocs.io/en/latest/040_backup.html#excluding-files";
    };
    additionalExclude = lib.mkOption {
      default = [ ];
      example = [ ];
      type = lib.types.listOf lib.types.str;
      description = "Additional files you want to exclude";
    };
    pruneOpts = lib.mkOption {
      default = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 3"
        "--keep-yearly 1"
      ];
      example = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 3"
        "--keep-yearly 1"
      ];
      type = lib.types.listOf lib.types.str;
    };

  };

  config =
    let
      moduleConfig = config.modules.backup;
    in
    lib.mkIf moduleConfig.enable {
      environment.systemPackages = with pkgs; [ restic ];

      services.restic.backups = {
        "${moduleConfig.name}" = {
          initialize = true;
          passwordFile = moduleConfig.passwordFile;
          repository = moduleConfig.repository;
          timerConfig.OnCalendar = moduleConfig.schedule;
          paths = moduleConfig.paths;
          exclude = moduleConfig.exclude ++ moduleConfig.additionalExclude;
          pruneOpts = moduleConfig.pruneOpts;
        };
      };

      environment.variables = {
        RESTIC_REST_USERNAME = moduleConfig.username;
      };
    };
}
