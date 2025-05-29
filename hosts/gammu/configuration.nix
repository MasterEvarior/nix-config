{ ... }:

{
  imports = [
    ./hardware.nix

    ../../nixosModules

    ../../users/htpc/htpc.nix
  ];

  networking = {
    hostName = "gammu";
    networkmanager.enable = true;
    wireless.enable = true;
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "htpc";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
