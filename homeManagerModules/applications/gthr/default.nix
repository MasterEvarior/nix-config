{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.gthr = {
    enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.homeModules.applications.gthr.enable {
  };
}