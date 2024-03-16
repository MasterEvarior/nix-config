{
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.configurationLimit = 60;
    efi.canTouchEfiVariables = true;
  };
}
