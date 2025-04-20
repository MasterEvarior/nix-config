{
  pkgs,
  ...
}:

let
  username = "htpc";
in
{
  imports = [ ./../../homeManagerModules ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    # Entertainment & Media
    plex-media-player
    vlc
  ];

  homeModules = {
    applications.module.enableDefaults = false;
    dev.module.enableDefaults = false;
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
