{ pkgs, lib, ... }:

{
  imports = [
    ./c.nix
    ./containers.nix
    ./java.nix
    ./js.nix
  ];

  modules.dev.containers.enable = lib.mkDefault true;
  modules.dev.java.enable = lib.mkDefault true;
  modules.dev.js.enable = lib.mkDefault true;

  environment.systemPackages = with pkgs; [ 
    vscode 
    git 
  ];

  environment.shellAliases = {
    gaa = "git add --all";
    ggraph = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
  };
}
