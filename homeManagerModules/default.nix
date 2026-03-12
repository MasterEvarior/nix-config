{ lib, ... }:
{
  imports = [
    ./applications
    ./desktop
    ./dev
    ./projects
    ./scripts
    ./sops.nix
    ./terminal
  ];

  homeModules.terminal.enable = lib.mkDefault true;
}
