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
    spotify
    plex-media-player
    vlc

    # Secret Management
    _1password
    _1password-gui
  ];

  homeModules.applications = {
    onedrive.enable = true;
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
