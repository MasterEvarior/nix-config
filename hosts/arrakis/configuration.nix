{ pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../nixosModules/dev
    ../../nixosModules/school
    ../../nixosModules/settings
    ../../nixosModules/grub2Theme
    ../../nixosModules/desktop

    ../../users/giannin/giannin.nix
    ../../users/work/work.nix
  ];

  # Enable flakes https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Networking
  networking = {
    hostName = "arrakis";
    networkmanager.enable = true;
  };
  modules.school.wifi = true;

  # Sound
  sound.enable = true;
  hardware.pulseaudio.enable = false;
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
  services.xserver = {
    enable = true;
    xkb = {
      layout = "ch";
      variant = "de_nodeadkeys";
    };
    desktopManager.plasma5.enable = true;
  };

  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
  };

  # Configure console keymap
  console.keyMap = "sg";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
  system.stateVersion = "23.11";
}