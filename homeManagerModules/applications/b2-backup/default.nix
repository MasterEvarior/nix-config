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
      description = "Name of the backup, should be unique for each host, user and over all of B2. Will be used to create the bucket name of the bucket.";
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
      default = "${config.home.homeDirectory}/.b2-backups";
      example = "${config.home.homeDirectory}/.b2-backups";
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
    encryptionPasswordEval = lib.mkOption {
      example = "cat /your/secret/password.txt";
      type = lib.types.str;
      description = "Command to retrieve the password for encrypting your password.";
    };
    b2AuthenticationEval = lib.mkOption {
      example = "$(cat -pp ~/your/application_key/id) $(cat -pp ~/your/application_key/key)";
      type = lib.types.str;
      description = "Command(s) to evluate your application key id and the key itself";
    };
    weeksToKeepBackups = lib.mkOption {
      default = 26;
      example = 26;
      type = lib.types.int;
      description = "Amount of weeks to keep the backups files before they get deleted";
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
      bucketType = "allPrivate";
      daysToKeep = cfg.weeksToKeepBackups * 7;
      lifecycleRule = builtins.toJSON {
        daysFromStartingToCancelingUnfinishedLargeFiles = 1;
        daysFromUploadingToHiding = daysToKeep;
        daysFromHidingToDeleting = 1;
        fileNamePrefix = "";
      };
      serviceName = "b2-backup";
    in
    lib.mkIf config.homeModules.applications.b2-backup.enable {
      home.packages = with pkgs; [
        backblaze-b2
        zip
        gnupg
      ];

      home.shellAliases = {
        "${serviceName}-show-timer" = "systemctl --user list-timers b2-backup.timer --all";
        "${serviceName}-now" = "systemctl --user start b2-backup.service";
      };

      systemd.user = {
        enable = true;

        services."${serviceName}" = {
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

              FILENAME="$(echo $(date +'%FT%H%M%S').zip)"
              FILEPATH="${cfg.localBackupDirectory}/$FILENAME"
              echo "Creating backup of files ${include} at $FILEPATH without ${exclude}"
              ${pkgs.zip}/bin/zip -q -r $FILEPATH ${include} ${exclude}

              echo "Encrypting backup"
              ENCRYPTED_FILENAME="$FILENAME.gpg"
              ENCRYPTED_FILEPATH="$FILEPATH.gpg"
              ${pkgs.gnupg}/bin/gpg --symmetric --cipher-algo AES256 --passphrase $(${cfg.encryptionPasswordEval}) --batch --output $ENCRYPTED_FILEPATH $FILEPATH

              echo "Logging into Backblaze B2"
              ${pkgs.backblaze-b2}/bin/b2v4 account authorize ${cfg.b2AuthenticationEval} > /dev/null

              echo "Uploading to bucket ${bucketName}"
              if ! ${pkgs.backblaze-b2}/bin/b2v4 bucket get ${bucketName}; then
                echo "${bucketName} not found, creating new bucket"
                ${pkgs.backblaze-b2}/bin/b2v4 bucket create ${bucketName} ${bucketType} 
              fi
              ${pkgs.backblaze-b2}/bin/b2v4 bucket update ${bucketName} ${bucketType} --lifecycle-rule '${lifecycleRule}'

              ${pkgs.backblaze-b2}/bin/b2v4 file upload ${bucketName} $ENCRYPTED_FILEPATH $ENCRYPTED_FILENAME --no-progress
              ${pkgs.backblaze-b2}/bin/b2v4 account clear

              echo "Cleaning up local backups at ${cfg.localBackupDirectory}"
              rm -rf ${cfg.localBackupDirectory}/*

              echo "Backup done!"
            ''}";
          };
        };

        timers."${serviceName}" = {
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
