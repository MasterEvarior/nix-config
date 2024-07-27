{ lib, ... }:
{
  imports = [ ./terminal ];

  homeModules.terminal.enable = lib.mkDefault true;
}
