{ lib, ... }:

{
  imports = [
    ./vscode
    ./fastfetch
  ];

  homeModules.programs.vscode.enable = lib.mkDefault true;
  homeModules.fastfetch.enable = lib.mkDefault true;
}
