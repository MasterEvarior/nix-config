{ lib, ... }:

{
  imports = [ ./terminal.nix ];

  modules.desktop.terminal.enable = lib.mkDefault true;
}
