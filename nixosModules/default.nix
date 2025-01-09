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
  ];

  modules = {
    terminal.enable = lib.mkDefault true;
    containers.enable = lib.mkDefault true;
    desktop.hyprland.enable = lib.mkDefault true;
  };
}
