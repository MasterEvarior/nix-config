{
  lib,
  config,
  ...
}:

{
  options.modules.settings.swap = {
    enable = lib.mkEnableOption "Swap Space";
    size = lib.mkOption {
      default = 16;
      example = 16;
      type = lib.types.int;
      description = "Size of the Swap space in GB";
    };
  };

  config =
    let
      cfg = config.modules.settings.swap;

    in
    lib.mkIf config.modules.settings.swap.enable {
      swapDevices = [
        {
          device = "/swapfile";
          size = cfg.size * 1024;
        }
      ];
    };
}
