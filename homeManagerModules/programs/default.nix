{ lib, ... }:

{
  imports = [ ./vscode.nix ];

  homeModules.programs.vscode.enable = lib.mkDefault true;
}
