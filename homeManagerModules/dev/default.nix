{ lib, ... }:

{
  imports = [ ./ansible ./golang ./js ];

  homeModules.dev.ansible.enable = lib.mkDefault true;
  homeModules.dev.golang.enable = lib.mkDefault true;
  homeModules.dev.js.enable = lib.mkDefault true;
}
