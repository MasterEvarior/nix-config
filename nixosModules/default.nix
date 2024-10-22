{ pkgs, ... }:

{
  imports = [
    ./1Password
    ./backup
    ./desktop
    ./grub2Theme
    ./settings
    ./containers
  ];

  modules = {
    containers.enable = true;
  };
}
