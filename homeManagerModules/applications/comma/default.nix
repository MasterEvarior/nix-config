{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.comma = {
    enable = lib.mkEnableOption "Comma";
  };

  config = lib.mkIf config.homeModules.applications.comma.enable {
    home.packages = with pkgs; [ comma ];
  };
}
