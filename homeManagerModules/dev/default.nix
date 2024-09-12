{ lib, ... }:

{
  imports = [
    ./ansible
    ./golang
    ./js
    ./c
  ];

  homeModules.dev.ansible.enable = lib.mkDefault true;
  homeModules.dev.golang.enable = lib.mkDefault true;
  homeModules.dev.js.enable = lib.mkDefault true;
  homeModules.dev.c.enable = lib.mkDefault false;
}
