{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.spotify = {
    enable = lib.mkEnableOption "Spotify Desktop App";
  };

  config = lib.mkIf config.homeModules.applications.spotify.enable {
    home.packages = with pkgs; [ spotify ];
  };
}
