{ lib, ... }:

{
  services.printing.enable = lib.mkDefault true;

  # Enable autodiscovery of network printers
  # https://nixos.wiki/wiki/Printing#Enable_autodiscovery_of_network_printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

}
