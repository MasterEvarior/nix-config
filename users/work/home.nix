{ pkgs, ... }:

{
  imports = [ ./../../homeManagerModules ];

  home.username = "work";
  home.homeDirectory = "/home/work";

  programs.git = {
    enable = true;
    userName = "Giannin";
    userEmail = "puzzle@giannin.ch";
  };

  home.packages = with pkgs; [
    # Secret Management
    _1password
    _1password-gui
    libfido2 # Security Token

    # Mail Client
    thunderbird
    
    # Music
    spotify 

    # Todo Manager
    dooit

    # Time Tracking
    watson
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
