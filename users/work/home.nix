{ pkgs, ... }:

{
  imports = [ ./../../homeManagerModules ];

  home.username = "work";
  home.homeDirectory = "/home/work";

  home.packages = with pkgs; [
    # Secret Management
    libfido2 # Security Token

    # Office
    thunderbird
    nextcloud-client

    # Media
    vlc
  ];

  homeModules = {
    applications = {
      dooit.enable = true;
      cypress = {
        enable = true;
      };
      deja-dup.enable = true;
      watson.enable = true;
      bitwarden.enable = true;
      zellij.additionalLayouts = ./assets/zellij-layouts;
    };
    dev = {
      git = {
        enable = true;
        userName = "Giannin";
        userEmail = "puzzle@giannin.ch";
      };
      php.enable = true;
      kubernetes = {
        enable = true;
        openshift.enable = true;
      };
      latex.enable = true;
    };
  };

  homeModules.dev.git.rebase = true;

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
