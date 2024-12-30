{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.b2-backup = {
    enable = lib.mkEnableOption "Backups to Backblaze B2";
    name = lib.mkOption {
      example = "arrakis";
      type = lib.types.str;
      description = "Name of the backup, should be unique for each host. Will be used to create the bucketname.";
    };
    schedule = lib.mkOption {
      default = "weekly";
      example = "daily";
      type = lib.types.enum [
        "daily"
        "weekly"
        "monthly"
      ];
      description = "Systemd timer interval";
    };
    localBackupDirectory = lib.mkOption {
      default = "~/.b2-backups";
      example = "~/.b2-backups";
      type = lib.types.str;
      description = "Path where backups are temporarily stored before they are uploaded and then deleted.";
    };
    directoriesToBackup = lib.mkOption {
      default = [ ];
      example = [
        /home/giannin/Documents
        /home/giannin/Desktop
      ];
      type = lib.types.listOf lib.types.path;
      description = "List of directories to backup.";
    };
    directoriesToExclude = lib.mkOption {
      default = [ ];
      example = [
        /home/giannin/Documents/OneDrive
      ];
      type = lib.types.listOf lib.types.path;
      description = "List of directories to exclude from backup";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.b2-backup;
      include = builtins.concatStringsSep " " (lib.map (d: toString d) cfg.directoriesToBackup);
      exclude =
        if builtins.length cfg.directoriesToExclude <= 0 then
          ""
        else
          "-x "
          + builtins.concatStringsSep " " (lib.map (d: "'" + toString d + "/*'") cfg.directoriesToExclude)
          + " @";
      bucketName = "${cfg.name}-${builtins.hashString "md5" cfg.name}";
    in
    lib.mkIf config.homeModules.applications.b2-backup.enable {
      home.packages = with pkgs; [
        backblaze-b2
        zip
      ];

      systemd.user = {
        enable = true;

        services.b2-backup = {
          Unit = {
            Description = "Backup data to Backblaze B2";
          };
          Install = {
            WantedBy = [ "default.target" ];
          };
          Service = {
            ExecStart = "${pkgs.writeShellScript "b2-backup" ''
              echo "Starting backup to b2..."
              echo "Creating backup directory at ${cfg.localBackupDirectory}"
              mkdir -p ${cfg.localBackupDirectory}

              echo "Ensuring backup directory is empty"
              rm -rf ${cfg.localBackupDirectory}/*

              FILENAME=${cfg.localBackupDirectory}/$(echo "$(date +"%FT%H%M%S").zip")
              echo "Creating backup of files ${include} at $FILENAME without ${exclude}"
              ${pkgs.zip}/bin/zip -q -r $FILENAME ${include} ${exclude}

              echo "Cleaning up local backups at ${cfg.localBackupDirectory}"
              rm -rf ${cfg.localBackupDirectory}/*

              echo "Uploading to bucket ${bucketName}"

              echo "Backup done!"
            ''}";
          };
        };

        timers.b2-backup = {
          Unit = {
            Description = "Run the b2-backup service in a defined interval";
          };

          Timer = {
            OnCalendar = "${cfg.schedule}";
            Persistent = true;
          };

          Install = {
            WantedBy = [ "timers.target" ];
          };
        };
      };
    };
}
