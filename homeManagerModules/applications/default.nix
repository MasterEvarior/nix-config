{ lib, ... }:

{
  imports = [
    ./vscode
    ./fastfetch
    ./dooit
  ];

  homeModules.programs.vscode.enable = lib.mkDefault true;
  homeModules.fastfetch.enable = lib.mkDefault true;
  homeModules.dooit.enable = lib.mkDefault false;
}
