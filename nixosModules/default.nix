{ lib, ... }:

{
  imports = [
    ./1Password
    ./desktop
    ./grub2Theme
    ./settings
    ./terminal
    ./containers
    ./nvidia
    ./displaylink
    ./plasma
  ];

  modules = {
    terminal.enable = lib.mkDefault true;
    containers.enable = lib.mkDefault true;
    desktop.hyprland.enable = lib.mkDefault true;
    desktop.plasma.enable = lib.mkDefault true;
  };
}
