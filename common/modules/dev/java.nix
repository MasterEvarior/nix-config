{pkgs, ... }:

{
   environment.systemPackages = with pkgs; [
      pkgs.jetbrains.idea-ultimate
      pkgs.zulu17
   ];
}
