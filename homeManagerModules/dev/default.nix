{ lib, ... }:

{
  imports = [
    ./ansible
    ./golang
    ./js
    ./c
    ./nix
  ];

  homeModules.dev = {
    ansible.enable = lib.mkDefault true;
    golang.enable = lib.mkDefault true;
    js.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
  };
}
