{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.dooit = {
    enable = lib.mkEnableOption "Dooit with a custom config";
  };

  config = lib.mkIf config.homeModules.applications.dooit.enable {
    home.packages = with pkgs; [ dooit ];

    home.file.".config/dooit/config.py".source = ./assets/config.py;
  };
}
