{ config, ... }:

{
  imports = [
    ./hardware.nix

    ../../nixosModules

    ../../users/giannin/giannin.nix
  ];

  modules = {
    # Enable unfree Nvidia trash
    nvidia.enable = true;

    displayManager.sddm = {
      enable = true;
      theme = "Silent-SDDM";
      silent-sddm.flavor = "catppuccin-mocha";
      catppuccin-official.wallpaper = ./assets/wallpapers/sddm/background.png;
    };

    desktop =
      let
        ultrawide = "LG Electronics LG ULTRAWIDE 0x00059AB6";
        side = "AOC 24G2W1G4 ATNN11A013004";
      in
      {
        plasma.enable = true;
        sway = {
          enable = true;
          useSwayFX = true;
          disableHardwareCursor = true;
          enableUnsupportedGPU = true;
          focusOnStartup = ultrawide;
          outputs = {
            "${ultrawide}" = {
              mode = "2560x1080";
              bg = "${./assets/wallpapers/desktop/horizontal/ocean_with_cloud.png} fill";
              pos = "0,0";
            };
            ${side} = {
              mode = "1920x1080";
              bg = "${./assets/wallpapers/desktop/vertical/anime-landscape-7.png} fill";
              pos = "2560,0";
              transform = "90";
            };
          };
          workspaceAssignments = [
            {
              outputName = ultrawide;
              workspace = 1;
            }
            {
              outputName = side;
              workspace = 10;
            }
          ];
        };
      };

    grub2Theme = {
      enabled = true;
      resolution = "ultrawide";
      backgroundImage = ./assets/wallpapers/grub/ultrawide-background.jpg;
    };

    sops = {
      enable = true;
      secretsToLoad = {
        "unraid/smb-credentials-1" = { };
      };
    };

    smb = {
      enable = true;
      shares = [
        {
          path = "/tower/movies";
          source = "//192.168.68.56/movies";
          credentials = config.sops.secrets."unraid/smb-credentials-1".path;
        }
        {
          path = "/tower/tv";
          source = "//192.168.68.56/tv";
          credentials = config.sops.secrets."unraid/smb-credentials-1".path;
        }
        {
          path = "/tower/photos";
          source = "//192.168.68.56/photos";
          credentials = config.sops.secrets."unraid/smb-credentials-1".path;
        }
      ];
    };
    settings.garbageCollection = {
      enable = true;
      keep = 90;
    };
  };

  # Probe for other OSs to facilitate dual boot
  boot.loader.grub.useOSProber = true;

  # Networking
  networking = {
    hostName = "caladan";
    networkmanager.enable = true;
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
