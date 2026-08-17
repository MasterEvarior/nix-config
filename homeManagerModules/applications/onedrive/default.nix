{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.applications.onedrive = {
    enable = lib.mkEnableOption "Onedrive";
    configuration = lib.mkOption {
      default = ''
        sync_dir = "~/Documents/OneDrive"
        disable_notifications = "true"
      '';
      example = "";
      type = lib.types.str;
      description = "Configuration file for the Onedrive client, see more here https://github.com/abraunegg/onedrive/blob/master/docs/USAGE.md";
    };
  };

  config = lib.mkIf config.homeModules.applications.onedrive.enable {
    home.packages = with pkgs-unstable; [ onedrive ];

    home.file.".config/onedrive/config".text = config.homeModules.applications.onedrive.configuration;
  };
}
