{ lib, ... }:
{
  services.printing.enable = lib.mkDefault true;
}
