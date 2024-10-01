{ lib, ... }:

{
  imports = [
    ./ansible
    ./golang
    ./js
    ./c
    ./nix
    ./typst
    ./jupyter
    ./git
    ./terraform
    ./java
  ];

  homeModules.dev = {
    ansible.enable = lib.mkDefault true;
    golang.enable = lib.mkDefault true;
    js.enable = lib.mkDefault true;
    nix.enable = lib.mkDefault true;
    typst.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    java.enable = lib.mkDefault true;
  };
}
