{ lib, ... }:

{
  imports = [
    ./vscode
    ./fastfetch
    ./dooit
    ./deja-dup
    ./cypress
  ];

  homeModules.programs.vscode.enable = lib.mkDefault true;
  homeModules.fastfetch.enable = lib.mkDefault true;
  homeModules.dooit.enable = lib.mkDefault false;
  homeModules.deja-dup.enable = lib.mkDefault false;
  homeModules.cypress.enable = lib.mkDefault false;
}
