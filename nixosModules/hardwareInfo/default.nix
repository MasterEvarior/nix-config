{ lib, ... }:
{
  options.modules.hardwareInfo = {
    gpu = lib.mkOption {
      type = lib.types.enum [
        "none"
        "nvidia"
        "amd"
        "intel"
      ];
    };
    type = lib.mkOption {
      type = lib.types.enum [
        "desktop"
        "laptop"
        "server"
      ];
    };
  };

  config.modules.hardwareInfo = { };
}
