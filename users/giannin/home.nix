{pkgs, ...}:

{
  home.username = "giannin";
  home.homeDirectory = "/home/giannin";

  programs.git = {
    enable = true;
    userName = "Giannin";
    userEmail = "contact@giannin.ch";
  };

  home.packages = with pkgs; [

      # Entertainment
      spotify
      plex-media-player

      # Secret Management
      _1password 
      _1password-gui
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}