{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ pkgs.vscode pkgs.git ];
}
