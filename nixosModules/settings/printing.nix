{
  lib,
  config,
  ...
}:

{
  options.modules.settings.printing = {
    enable = lib.mkEnableOption "Printing";
    enableAutoDiscovery = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to enable the auto discovery of network printers";
    };
  };

  config =
    let
      cfg = config.modules.settings.printing;
    in
    lib.mkIf config.modules.settings.printing.enable {
      services.printing.enable = true;

      # Enable autodiscovery of network printers
      # https://nixos.wiki/wiki/Printing#Enable_autodiscovery_of_network_printers
      services.avahi = {
        enable = cfg.enableAutoDiscovery;
        nssmdns4 = cfg.enableAutoDiscovery;
        openFirewall = cfg.enableAutoDiscovery;
      };
    };
}
