{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.ms-teams = {
    enable = lib.mkEnableOption "Inofficial Microsoft Teams client";
  };

  config = lib.mkIf config.homeModules.applications.ms-teams.enable {
    home.packages = with pkgs; [ teams-for-linux ];
  };
}
