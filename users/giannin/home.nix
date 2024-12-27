{ pkgs, ... }:

{
  imports = [ ./../../homeManagerModules ];

  home.username = "giannin";
  home.homeDirectory = "/home/giannin";

  home.packages = with pkgs; [
    # Entertainment & Media
    plex-media-player
    vlc

    # School stuff
    mdbook

    # Wallpapers
    gowall
  ];

  homeModules = {
    applications = {
      onedrive.enable = true;
      zotero.enable = true;
      signal.enable = true;
      cypress = {
        enable = true;
        additionalBrowsers = [ ];
      };
      zellij.additionalLayouts = ./assets/zellij-layouts;
    };

    dev.git = {
      enable = true;
      userName = "Giannin";
      userEmail = "contact@giannin.ch";
    };
  };

  homeModules.dev = {
    terraform.enable = true;
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
