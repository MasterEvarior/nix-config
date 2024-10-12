{ lib, ... }:

{
  imports = [ ./containers.nix ];

  modules.dev.containers.enable = lib.mkDefault true;
}
