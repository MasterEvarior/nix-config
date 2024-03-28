{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pkgs.jetbrains.clion
    pkgs.gcc
    pkgs.gnumake
  ];
}
