{ pkgs, ... }:

{
  imports = [ ./ansible ];

  homeModules.dev.ansible.enable = lib.mkDefault true;
}
