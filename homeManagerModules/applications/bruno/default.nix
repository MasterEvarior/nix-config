{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.bruno = {
    enable = lib.mkEnableOption "Bruno";
  };

  config = lib.mkIf config.homeModules.applications.bruno.enable {
    home.packages = with pkgs; [
      bruno
      bruno-cli
    ];
  };
}
