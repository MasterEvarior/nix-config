{ lib, ... }:
{
  imports = [
    ./terminal
    ./desktop
  ];

  homeModules.terminal.enable = lib.mkDefault true;
}
