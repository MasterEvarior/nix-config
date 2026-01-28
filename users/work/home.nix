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
          additionalPublicKeys =
            let
              bfhPublicCertificate = ./assets/ssh/BFH.pub;
              bfhUser = "ext-brag2";
            in
            [
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
              {
                host = "ssh.esb.bfh.ch";
                user = bfhUser;
                file = bfhPublicCertificate;
              }
              {
                host = "master*.k8s.bfh.ch";
                user = bfhUser;
                proxyJump = bfhUser + "@ssh.esb.bfh.ch";
                file = bfhPublicCertificate;
                localForwards = [
                  {
                    bind.port = 16443;
                    host = {
                      address = "127.1";
                      port = 6443;
                    };
                  }
                ];
              }
              {
                host = "*.esb.bfh.ch *.k8s.bfh.ch !ssh.esb.bfh.ch !node1.ssh.esb.bfh.ch !node2.ssh.esb.bfh.ch";
                user = bfhUser;
                proxyJump = bfhUser + "@ssh.esb.bfh.ch";
                file = bfhPublicCertificate;
              }
              {
                host = "ssh.esb-test.bfh.ch";
                user = bfhUser;
                file = bfhPublicCertificate;
              }
              {
                host = "master*.k8s-test.bfh.ch";
                user = bfhUser;
                file = bfhPublicCertificate;
                proxyJump = bfhUser + "@ssh.esb-test.bfh.ch";
                localForwards = [
                  {
                    bind.port = 16443;
                    host = {
                      address = "127.1";
                      port = 6443;
                    };
                  }
                ];
              }
              {
                host = "*.esb-test.bfh.ch *.k8s-test.bfh.ch !ssh.esb-test.bfh.ch !node1.ssh.esb-test.bfh.ch !node2.ssh.esb-test.bfh.ch";
                user = bfhUser;
                proxyJump = bfhUser + "@ssh.esb-test.bfh.ch";
                file = bfhPublicCertificate;
              }
              {
                host = "*.bfh.ch !*.esb.bfh.ch !*.k8s.bfh.ch !*.esb-test.bfh.ch !*.k8s-test.bfh.ch";
                user = bfhUser;
                proxyJump = bfhUser + "@ssh.bfh.science";
                file = bfhPublicCertificate;
              }
              {
                host = "ssh.bfh.science";
                user = bfhUser;
                file = bfhPublicCertificate;
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
