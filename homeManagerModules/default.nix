{ lib, ... }:
{
  imports = [
    ./terminal
    ./desktop
    ./fastfetch
  ];

  homeModules.terminal.enable = lib.mkDefault true;
  homeModules.fastfetch.enable = lib.mkDefault true;
}
