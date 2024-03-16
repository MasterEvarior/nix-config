{pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      pkgs.vscode
      pkgs.git
      pkgs.jetbrains.idea-ultimate
   ];
}
