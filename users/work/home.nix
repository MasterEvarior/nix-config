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

    # Music
    spotify

    # Office
    thunderbird
    libreoffice
    watson
    nextcloud-client
  ];

  homeModules.dooit.enable = true;
  homeModules.cypress.enable = true;
  homeModules.deja-dup.enable = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
