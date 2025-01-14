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
    # Entertainment & Media
    plex-media-player
    vlc
    handbrake

    # School stuff
    mdbook

    # Wallpapers
    gowall
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
      cypress = {
        enable = true;
        additionalBrowsers = [ ];
      };
      zellij.additionalLayouts = ./assets/zellij-layouts;

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
      minikube.enable = true;
      git = {
        enable = true;
        userName = "Giannin";
        userEmail = "contact@giannin.ch";
      };
    };
  };

  homeModules.dev = {
    terraform.enable = true;
  };

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
