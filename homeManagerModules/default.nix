{ lib, ... }:
{
  imports = [
    ./terminal
    ./desktop
    ./applications
    ./dev
  ];

  homeModules.terminal.enable = lib.mkDefault true;
}
