{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    jetbrains-mono
    nerdfonts
    cascadia-code
  ];
}
