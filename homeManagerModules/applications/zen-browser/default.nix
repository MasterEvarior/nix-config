{
  lib,
  config,
  zen-browser,
  ...
}:

{
  options.homeModules.applications.zen-browser = {
    enable = lib.mkEnableOption "Zen Browser";
  };

  config = lib.mkIf config.homeModules.applications.zen-browser.enable {
    home.packages = [
      zen-browser
    ];

  };
}
