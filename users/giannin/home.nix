{
  pkgs,
  osConfig,
  config,
  ...
}:

let
  username = "giannin";
in
{
  imports = [ ./../../homeManagerModules ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    # Media
    vlc
  ];

  homeModules = {
    sops = {
      enable = true;
      secretsToLoad = {
        "b2_backup/passphrase" = { };
        "b2_backup/application_key/id" = { };
        "b2_backup/application_key/key" = { };
      };
    };

    applications = {
      onedrive.enable = true;
      zotero.enable = true;
      gowall.enable = true;
      bruno.enable = true;
      mdbook.enable = true;
      openconnect = {
        enable = true;
        aliases = [
          {
            name = "fhnw";
            server = "vpn.fhnw.ch";
          }
        ];
      };
      "1password" = {
        enable = true;
        ssh = {
          configureSSH = true;
          additionalPublicKeys = [
            {
              host = "192.168.68.66";
              file = ./assets/ssh/homelab_1.pub;
            }
            {
              host = "gitlab.fhnw.ch";
              file = ./assets/ssh/gitlab_fhnw.pub;
            }
            {
              host = "185.79.235.161";
              file = ./assets/ssh/cloudscale.pub;
            }
          ];
        };
      };
      cypress = {
        enable = true;
        additionalBrowsers = [ ];
      };

      b2-backup = {
        enable = true;
        name = "${osConfig.networking.hostName}-${username}";
        encryptionPasswordEval = "${pkgs.bat}/bin/bat -pp ${
          config.sops.secrets."b2_backup/passphrase".path
        }";
        b2AuthenticationEval = "$(${pkgs.bat}/bin/bat -pp ${
          config.sops.secrets."b2_backup/application_key/id".path
        }) $(${pkgs.bat}/bin/bat -pp ${config.sops.secrets."b2_backup/application_key/key".path})";
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

    dev = {
      kubernetes = {
        enable = true;
        minikube.enable = false;
        flux.enable = false;
      };
      js = {
        enable = true;
        typescript.enable = true;
        angular.enable = true;
      };
      golang = {
        enable = true;
        setupVisualStudioCode = true;
      };
      python = {
        enable = true;
        setupVisualStudioCode = true;
      };
      git = {
        enable = true;
        userName = "Giannin";
        userEmail = "contact@giannin.ch";
      };
    };
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
