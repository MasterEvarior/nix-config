{ lib, ... }:

{
  imports = [
    ./vscode
    ./fastfetch
    ./dooit
    ./deja-dup
    ./cypress
    ./comma
  ];

  homeModules.applications.vscode.enable = lib.mkDefault true;
  homeModules.applications.fastfetch.enable = lib.mkDefault true;
  homeModules.applications.dooit.enable = lib.mkDefault false;
  homeModules.applications.deja-dup.enable = lib.mkDefault false;
  homeModules.applications.cypress.enable = lib.mkDefault false;
  homeModules.applications.comma.enable = lib.mkDefault true;
}
