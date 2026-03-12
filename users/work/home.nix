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

    # VPN
    openvpn

    # Media
    vlc
  ];

  homeModules = {
    projects = {
      bfh.enable = true;
    };

    applications = {
      bruno.enable = true;
      codegrab.enable = true;
      opencode.enable = true;
      cypress.enable = true;
      espanso.enable = true;
      mdbook.enable = true;
      deja-dup.enable = true;
      bitwarden.enable = true;
      meld.enable = true;
      github-cli.enable = true;
      gitlab-cli.enable = true;
      "1password" = {
        enable = true;
        ssh = {
          configureSSH = true;
          additionalPublicKeys = [
            {
              host = "webtransfer.ch";
              file = ./assets/ssh/webtransfer.pub;
              identitiesOnly = true;
            }
            {
              host = "gitlab.puzzle.ch";
              file = ./assets/ssh/gitlab_puzzle.pub;
              identitiesOnly = true;
            }
            {
              host = "code.ssb.ch";
              file = ./assets/ssh/sbb.pub;
              identitiesOnly = true;
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
      java.javaPackage = pkgs.jdk17;
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
