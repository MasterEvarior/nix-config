{pkgs, ...}:

{
  boot.loader = {
    grub.enable = true;
    grub.configurationLimit = 20;
    efi.canTouchEfiVariables = true;
  };

  # Updating the kernel to make it (hopefully) compatible with the Lenovo docking stations
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
