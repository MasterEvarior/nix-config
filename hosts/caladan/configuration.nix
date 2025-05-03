{ ... }:

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
      wallpaper = ./assets/wallpapers/sddm/background.png;
    };

    desktop = {
      plasma.enable = true;
      sway.enable = true;
    };

    grub2Theme = {
      enabled = true;
      resolution = "ultrawide";
      backgroundImage = ./assets/wallpapers/grub/ultrawide-background.jpg;
    };

    settings.garbageCollection = {
      enable = true;
      keep = 3;
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

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "ch";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "sg";

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
