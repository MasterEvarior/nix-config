{ lib, ... }:

{
  imports = [
    ./1Password
    ./backup
    ./desktop
    ./grub2Theme
    ./settings
    ./terminal
    ./containers
    ./nvidia
  ];

  modules = {
    terminal.enable = lib.mkDefault true;
    containers.enable = lib.mkDefault true;
    desktop.hyprland.enable = lib.mkDefault true;
  };
}
