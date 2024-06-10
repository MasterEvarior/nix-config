{pkgs, ...}:

{
  boot.loader = {
    grub.enable = true;
    grub.configurationLimit = 20;
    grub.efiSupport = true;

    # this will tell Grub that there is no need to install itself
    # because it is a UEFI boot
    # https://discourse.nixos.org/t/question-about-grub-and-nodev/37867/2
    grub.device = "nodev";

    efi.canTouchEfiVariables = true;

    # https://github.com/vinceliuice/grub2-themes/issues/190
    grub2-theme = {
      enable = true;
      theme = "stylish";
      footer = true;
      screen = "4k";
      splashImage = ./oled-background.png;
    };

    environment.systemPackages = with pkgs;
    [
      # this is needed to scale the custom background correctly
      imagemagick
    ];
  };
  
  # Updating the kernel to make it (hopefully) compatible with the Lenovo docking stations
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
