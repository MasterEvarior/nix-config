{ lib, ... }:

{
  imports = [
    ./1Password
    ./desktop
    ./grub2Theme
    ./settings
    ./sops
    ./terminal
    ./containers
    ./nvidia
    ./displaylink
    ./sddm
  ];

  modules = {
    terminal.enable = lib.mkDefault true;
    containers.enable = lib.mkDefault true;
    desktop.plasma.enable = lib.mkDefault true;
  };
}
