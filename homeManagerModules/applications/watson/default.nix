{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.watson = {
    enable = lib.mkEnableOption "Watson CLI for time tracking";
    package = lib.mkPackageOption pkgs "watson" { };
  };

  config =
    let
      cfg = config.homeModules.applications.watson;
    in
    lib.mkIf config.homeModules.applications.watson.enable {
      programs.watson = {
        enable = true;
        enableZshIntegration = true;
        package = cfg.package;
        # https://github.com/TailorDev/Watson/blob/master/docs/user-guide/configuration.md
        settings = {
          options = {
            reverse_log = true;
            week_start = "monday";
            confirm_new_project = true;
            confirm_new_tag = true;
            stop_on_start = true;
          };
        };
      };

      home.shellAliases = {
        w = lib.getExe cfg.package;
        wtdy = "${lib.getExe cfg.package} aggregate --from $(date -I)";
        wydy = "${lib.getExe cfg.package} aggregate --from $(date -I --date='yesterday')";
        wbdy = "${lib.getExe cfg.package} aggregate --from $(date -I --date='+2 days ago')";
      };

    };
}
