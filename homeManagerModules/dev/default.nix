{ lib, ... }:

{
  imports = [ ./ansible ./golang];

  homeModules.dev.ansible.enable = lib.mkDefault true;
  homeModules.dev.golang.enable = lib.mkDefault true;
}
