{ lib, ... }:
{
  imports = [
    ./terminal
    ./desktop
    ./fastfetch
    ./programs
  ];

  homeModules.terminal.enable = lib.mkDefault true;
  homeModules.fastfetch.enable = lib.mkDefault true;
}
