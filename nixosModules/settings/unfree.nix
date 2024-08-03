{ lib, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = lib.mkDefault true;
}
