{
  lib,
  config,
  ...
}:

{
  options.modules.settings.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth";
  };

  config = lib.mkIf config.modules.settings.bluetooth.enable {
    hardware.bluetooth.enable = true;
  };
}
