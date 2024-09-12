{ lib, ... }:

{
  imports = [
    ./ansible
    ./golang
    ./js
    ./c
    ./nix
  ];

  homeModules.dev.ansible.enable = lib.mkDefault true;
  homeModules.dev.golang.enable = lib.mkDefault true;
  homeModules.dev.js.enable = lib.mkDefault true;
  homeModules.dev.nix.enable = lib.mkDefault true;
}
