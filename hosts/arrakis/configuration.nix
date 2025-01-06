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
  };
  # to connect to the Eduroam WIFI, it is necessary to install these certificates
  security.pki.certificateFiles = [
    ./assets/eduroam/DigiCertGlobalRootCA.pem
    ./assets/eduroam/DigiCertTLSRSASHA2562020CA1-1.pem
  ];

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Custom bootloader theming
  modules.grub2Theme = {
    enabled = true;
    resolution = "4k";
    backgroundImage = ./assets/img/oled-background.png;
  };

  # Configure keymap in X11
  services = {
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "ch";
        variant = "de_nodeadkeys";
      };
    };
  };

  programs.hyprland.enable = true;

  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
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
