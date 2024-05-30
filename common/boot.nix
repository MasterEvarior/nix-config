{pkgs, ...}:

{
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 60;
    efi.canTouchEfiVariables = true;
  };

  # Updating the kernel to make it (hopefully) compatible with the Lenovo docking stations
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
