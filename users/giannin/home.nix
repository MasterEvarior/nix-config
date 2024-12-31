{ pkgs, osConfig, ... }:

let
  username = "giannin";
in
{
  imports = [ ./../../homeManagerModules ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    # Entertainment & Media
    plex-media-player
    vlc

    # School stuff
    mdbook

    # Wallpapers
    gowall
  ];

  sops = {
    age.keyFile = "/home/giannin/.config/sops/age/keys.txt"; # must have no password!
  };

  homeModules = {
    applications = {
      onedrive.enable = true;
      zotero.enable = true;
      cypress = {
        enable = true;
        additionalBrowsers = [ ];
      };
      zellij.additionalLayouts = ./assets/zellij-layouts;
      b2-backup = {
        enable = true;
        name = "${osConfig.networking.hostName}-${username}";
        directoriesToBackup = [
          /home/giannin/Downloads
          /home/giannin/Pictures
          /home/giannin/Templates
          /home/giannin/Desktop
          /home/giannin/Videos
          /home/giannin/Music
          /home/giannin/Documents
        ];
        directoriesToExclude = [
          /home/giannin/Documents/Github
          /home/giannin/Documents/GitHub
          /home/giannin/Documents/OneDrive
        ];
      };
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
