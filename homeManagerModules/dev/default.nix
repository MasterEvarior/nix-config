{ lib, ... }:

{
  imports = [
    ./ansible
    ./golang
    ./js
    ./c
    ./nix
    ./typst
  ];

  homeModules.dev = {
    ansible.enable = lib.mkDefault true;
    golang.enable = lib.mkDefault true;
    js.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    typst.enable = lib.mkDefault true;
  };
}
