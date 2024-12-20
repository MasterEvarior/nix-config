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
    ./python
    ./openshift
  ];

  homeModules.dev = {
    js = {
      enable = lib.mkDefault true;
      typescript.enable = lib.mkDefault true;
    };
    nix.enable = lib.mkDefault true;
    typst.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    java.enable = lib.mkDefault true;
  };
}
