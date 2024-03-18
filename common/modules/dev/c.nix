{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ pkgs.jetbrains.clion ];
}
