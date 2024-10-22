{ pkgs, ... }:

{
  imports = [
    ./1Password
    ./backup
    ./desktop
    ./grub2Theme
    ./settings
    ./terminal
    ./containers
  ];

  modules = {
    terminal.enable = lib.mkDefault true;
    containers.enable = lib.mkDefault true;
    desktop.enable = lib.mkDefault true;
  };
}
