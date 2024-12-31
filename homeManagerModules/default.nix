{ lib, ... }:
{
  imports = [
    ./terminal
    ./desktop
    ./applications
    ./dev
    ./sops.nix
  ];

  homeModules.terminal.enable = lib.mkDefault true;
}
