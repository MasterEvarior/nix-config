{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.applications.ms-teams = {
    enable = lib.mkEnableOption "Inofficial Microsoft Teams client";
  };

  config = lib.mkIf config.homeModules.applications.ms-teams.enable {
    home.packages = with pkgs-unstable; [ teams-for-linux ];
  };
}
