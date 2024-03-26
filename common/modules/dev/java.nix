{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pkgs.jetbrains.idea-ultimate
    pkgs.maven
    pkgs.gradle_7
  ];

  programs.java = {
    package=pkgs.jdk21;
    enable=true;
  };
}
