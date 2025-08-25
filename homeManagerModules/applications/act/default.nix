{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.act = {
    enable = lib.mkEnableOption "Local GitHub Actions Runner";
  };

  config = lib.mkIf config.homeModules.applications.act.enable {
    home.packages = with pkgs; [
      act
    ];
  };
}
