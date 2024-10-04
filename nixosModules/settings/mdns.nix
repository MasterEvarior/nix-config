{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.settings.mdns = {
    enable = lib.mkEnableOption "mDNS resolution with avahi";
  };

  config = lib.mkIf config.modules.settings.mdns.enable {
    services.avahi = {
      nssmdns4 = true;
      enable = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
      };
    };
  }; 
}