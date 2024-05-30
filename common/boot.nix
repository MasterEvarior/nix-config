{pkgs, ...}:

{
  boot.loader = {
    grub.enable = true;
    grub.configurationLimit = 20;
    
    # this will tell Grub that it does not need to install itself
    # because it is a UEFI boot
    # https://discourse.nixos.org/t/question-about-grub-and-nodev/37867/2
    grub.device = "nodev";

    efi.canTouchEfiVariables = true;
  };

  # Updating the kernel to make it (hopefully) compatible with the Lenovo docking stations
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
