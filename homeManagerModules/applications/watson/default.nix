{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.watson = {
    enable = lib.mkEnableOption "Watson CLI for time tracking";
  };

  config = lib.mkIf config.homeModules.applications.watson.enable {
    programs.watson = {
      enable = true;
      enableZshIntegration = true;
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
  };
}
