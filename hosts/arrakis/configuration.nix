{ ... }:

{
  imports = [
    ./hardware.nix

    ../../nixosModules

    ../../users/giannin/giannin.nix
    ../../users/work/work.nix
  ];

  # Networking
  networking = {
    hostName = "arrakis";
    networkmanager.enable = true;
    extraHosts = ''
      127.0.0.1 edview.unilu.ch 
      127.0.0.1 edview-test.unilu.ch
      127.0.0.1	webtransfer.local
      127.0.0.1	webtransfer.container
    '';
  };
  # to connect to the Eduroam WIFI, it is necessary to install these certificates
  security.pki.certificateFiles = [
    ./assets/eduroam/DigiCertGlobalRootCA.pem
    ./assets/eduroam/DigiCertTLSRSASHA2562020CA1-1.pem
  ];

  # APSI Stuff
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "giannin" ];

  modules = {
    displaylink.enable = true;
    grub2Theme = {
      enabled = true;
      resolution = "4k";
      backgroundImage = ./assets/img/oled-background.png;
    };
    displayManager.sddm = {
      enable = true;
      theme = "Silent-SDDM";
      silent-sddm.flavor = "catppuccin-mocha";
    };
    desktop = {
      plasma.enable = true;
      sway =
        let
          builtIn = "Samsung Display Corp. 0x4165";
        in
        {
          enable = true;
          useSwayFX = true;
          disableHardwareCursor = true;
          wayDisplayConfig = (builtins.readFile ./assets/sway-display-config.yaml);
          outputs = {
            "${builtIn}" = {
              mode = "3840x2400";
              bg = "${./assets/img/sway-background.png} fill";
              pos = "0,0";
            };
          };
          workspaceAssignments = [
            {
              outputName = builtIn;
              workspace = 1;
            }
          ];
        };
    };
  };

  # Configure keymap in X11
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "ch";
        variant = "de_nodeadkeys";
      };
    };
  };

  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
  };

  # Needed for work
  services.privoxy = {
    enable = true;
    settings = {
      forward-socks5 = "/ localhost:9999 .";
    };
  };

  # Enable Thunderbolt
  # https://nixos.wiki/wiki/Thunderbolt
  services.hardware.bolt.enable = true;

  # Configure console keymap
  console.keyMap = "sg";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
}
