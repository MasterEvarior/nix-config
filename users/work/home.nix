{ pkgs, ... }:

{
  imports = [ ./../../homeManagerModules ];

  home.username = "work";
  home.homeDirectory = "/home/work";

  home.packages = with pkgs; [
    # Secret Management
    libfido2 # Security Token

    # Programming
    yamllint
    mdl

    # Office
    thunderbird
    nextcloud-client
    # RDP Client
    remmina

    # Media
    vlc
  ];

  homeModules = {
    applications = {
      bruno.enable = true;
      cypress.enable = true;
      mdbook.enable = true;
      deja-dup.enable = true;
      bitwarden.enable = true;
      meld.enable = true;
      "1password" = {
        enable = true;
        ssh = {
          configureSSH = true;
          additionalPublicKeys = [
            {
              host = "webtransfer.ch";
              file = ./assets/ssh/webtransfer.pub;
            }
            {
              host = "gitlab.puzzle.ch";
              file = ./assets/ssh/gitlab_puzzle.pub;
            }
            {
              host = "gitlab.bfh.ch";
              file = ./assets/ssh/gitlab_bfh.pub;
            }
          ];
        };
      };
    };
    dev = {
      git = {
        enable = true;
        userName = "Giannin";
        userEmail = "puzzle@giannin.ch";
        rebase = true;
      };
      php.enable = true;
      kubernetes = {
        enable = true;
        openshift.enable = true;
      };
      js = {
        enable = true;
        angular.enable = true;
      };
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
