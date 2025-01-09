{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.displaylink = {
    enable = lib.mkEnableOption "DisplayLink";
  };

  config = lib.mkIf config.modules.displaylink.enable {
    environment.systemPackages = with pkgs; [
      displaylink
    ];

    services.xserver.videoDrivers = [
      "displaylink"
      "modesetting"
    ];
  };
}
