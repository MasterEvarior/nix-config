{ lib, ... }:
{
  imports = [
    ./applications
    ./desktop
    ./dev
    ./scripts
    ./sops.nix
    ./terminal
  ];

  homeModules.terminal.enable = lib.mkDefault true;
}
