{ lib, ... }:

{
  imports = [
    ./terminal.nix
    ./hyprland.nix
  ];

  modules.desktop.terminal.enable = lib.mkDefault true;
}
