{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.desktop.plasma = {
    enable = lib.mkEnableOption "Plasma Desktop Environmnet";
  };

  config = lib.mkIf config.modules.desktop.plasma.enable {
    services.desktopManager.plasma6 = {
      enable = true;
    };
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      khelpcenter
      krdp
    ];
  };
}
