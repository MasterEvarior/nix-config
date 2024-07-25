{ pkgs, lib, ... }:

{
  imports = [
    ./c.nix
    ./containers.nix
    ./java.nix
    ./js.nix
  ];

  dev.c.enable = lib.mkDefault false;
  dev.containers.enable = lib.mkDefault true;
  dev.java.enable = lib.mkDefault true;
  dev.js.enable = lib.mkDefault true;

  environment.systemPackages = with pkgs; [ 
    vscode 
    git 
  ];

  environment.shellAliases = {
    ggraph = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
  };
}
