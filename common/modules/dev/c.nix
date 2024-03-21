{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pkgs.jetbrains.clion
    pkgs.libgcc
    pkgs.gnumake
  ];
}
