{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.backup = {
    enable = lib.mkEnableOption "Backup with Restic";
    name = lib.lib.mkOption {
      default = config.networking.hostName;
      example = "arrakis";
      type = lib.types.string;
    };
    repository = lib.mkOption {
      default = "true";
      example = "rest:https://your-url.example.com";
      type = lib.types.string;
      description = "Wether to a configure the SSH config for the 1Password agent";
    };
    schedule = lib.mkOption {
      default = "daily";
      example = "daily";
      type = lib.types.string;
    };
    paths = .mkOption {
      default = [];
      example = [ "/home" ];
      type = lib.types.listOf lib.types.string;
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
      type = lib.types.listOf lib.types.string;
      description = "See https://restic.readthedocs.io/en/latest/040_backup.html#excluding-files";
    };
    additionalExclude = lib.mkOption {
      default = [ ];
      example = [ ];
      type = lib.types.listOf lib.types.string;
      description = "Additional files you want to exclude";
    };
    pruneOpts = lib.lib.mkOption {
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
      type = lib.types.listOf lib.types.string;
    };

  };


  config =
  let
    moduleConfig = config.modules.backup;
  in
  lib.mkIf moduleConfig.enable {
    environment.systemPackages = with pkgs; [
      restic
    ];

    services.restic.backups = {
      moduleConfig.name = {
        initialize = true;
        repository = moduleConfig.repository;
        timeConfig.OnCalendar = moduleConfig.schedule;
        paths = moduleConfig.paths;
        example = moduleConfig.exclude ++ moduleConfig.additionalExclude;
        pruneOpts = moduleConfig.pruneOpts;
      };
    };
  };
}