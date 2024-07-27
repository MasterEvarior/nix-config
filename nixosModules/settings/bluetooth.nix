{ lib, ... }:
{
  hardware.bluetooth.enable = lib.mkDefault true;
}
