{ lib, ... }:

{
  imports = [ ./school.nix ];

  modules.school.enable = lib.mkDefault true;
}
