# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../nixosModules

    ../../users/giannin/giannin.nix
  ];

  # Custom bootloader theming
  modules.grub2Theme = {
    enabled = true;
    resolution = "ultrawide";
    backgroundImage = ./assets/img/ultrawide-background.png;
  };

  modules.backup = {
    enable = true;
    repository = "rest:http://tower.local:8000";
    username = "restic-caladan";
    passwordFile = "/etc/nixos/secrets/resticPwd";
  };

  modules.desktop.hyprland = {
    enable = true;
    monitors = [
      "DP-1, 1920x1080@60, 2560x0, 1, transform, 3"
      "DP-3, 2560x1080@144, 0x0, 1"
      ", preferred, auto, 1"
    ];
  };

  # Enable unfree Nvidia trash
  modules.nvidia.enable = true;

  # Probe for other OSs to facilitate dual boot
  boot.loader.grub.useOSProber = true;

  # Networking
  networking = {
    hostName = "caladan";
    networkmanager.enable = true;
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb.layout = "ch";
    xkb.variant = "";
  };

  # Configure console keymap
  console.keyMap = "sg";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    nano
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
