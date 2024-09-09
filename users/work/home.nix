{ pkgs, ... }:

{
  imports = [ ./../../homeManagerModules ];

  home.username = "work";
  home.homeDirectory = "/home/work";

  programs.git = {
    enable = true;
    userName = "Giannin";
    userEmail = "puzzle@giannin.ch";
  };

  home.packages = with pkgs; [
    # Secret Management
    _1password
    _1password-gui
    
    # Mail Client
    thunderbird
    
    # Music
    spotify 
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
