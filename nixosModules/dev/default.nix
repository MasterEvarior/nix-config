{ pkgs, lib, ... }:

{
  imports = [
    ./containers.nix
    ./java.nix
  ];

  modules.dev.containers.enable = lib.mkDefault true;
  modules.dev.java.enable = lib.mkDefault true;
}
