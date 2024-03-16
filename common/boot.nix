{
  boot.loader = {
    grub = {
      enable = true;
      configurationLimit = 60;
      efiSupport = true;
    };

    efi.canTouchEfiVariables = true;
  };
}
