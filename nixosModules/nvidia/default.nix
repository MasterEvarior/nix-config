{ lib, config, ... }:

{
  options.modules.nvidia = {
    enable = lib.mkEnableOption "Unfree Nvidia Drivers and more";
  };

  config = lib.mkIf config.modules.nvidia.enable {
    # Most of this is straight from the wiki
    # https://nixos.wiki/wiki/Nvidia

    hardware.graphics.enable = true;

    hardware.nvidia = {
      modesetting.enable = true;

      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
