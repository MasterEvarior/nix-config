{ pkgs, lib, ... }:

{
  imports = [
    ./containers.nix
    ./java.nix
  ];

  modules.dev.containers.enable = lib.mkDefault true;
  modules.dev.java.enable = lib.mkDefault true;

  environment.systemPackages = with pkgs; [ git ];

  environment.shellAliases = {
    gaa = "git add --all";
    gamend = "git commit --amend --no-edit";
    ggraph = "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
  };
}
