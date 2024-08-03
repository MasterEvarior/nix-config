{ lib, ... }:
{
  imports = [
    ./terminal
    ./desktop
    ./applications
  ];

  homeModules.terminal.enable = lib.mkDefault true;
}
