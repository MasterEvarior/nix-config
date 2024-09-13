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
    libfido2 # Security Token

    # Office
    thunderbird
    libreoffice
    watson
    nextcloud-client
  ];

  homeModules.applications = {
    dooit.enable = true;
    cypress.enable = true;
    deja-dup.enable = true;
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
