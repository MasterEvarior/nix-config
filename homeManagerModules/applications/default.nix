{ lib, ... }:

{
  imports = [
    ./vscode.nix
    ./fastfetch
  ];

  homeModules.programs.vscode.enable = lib.mkDefault true;
  homeModules.fastfetch.enable = lib.mkDefault true;
}
