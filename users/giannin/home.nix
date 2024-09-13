{ pkgs, ... }:

{
  imports = [ ./../../homeManagerModules ];

  home.username = "giannin";
  home.homeDirectory = "/home/giannin";

  programs.git = {
    enable = true;
    userName = "Giannin";
    userEmail = "contact@giannin.ch";
  };

  home.packages = with pkgs; [
    # Entertainment & Media
    plex-media-player
    vlc
  ];

  homeModules.applications = {
    onedrive.enable = true;
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
