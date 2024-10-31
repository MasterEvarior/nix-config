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
    nextcloud-client
    chromium

    # SBOMs
    cyclonedx-cli
    cdxgen
    syft
  ];

  homeModules.applications = {
    dooit.enable = true;
    cypress.enable = true;
    deja-dup.enable = true;
    watson.enable = true;
    zellij.additionalLayouts = ./assets/zellij-layouts;
  };

  homeModules.dev.git.rebase = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
