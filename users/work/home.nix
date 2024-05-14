{pkgs, ...}:

{

  home.username = "work";
  home.homeDirectory = "/home/work";

  programs.git = {
    enable = true;
  };

  home.packages = with pkgs; [
    
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}