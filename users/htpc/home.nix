{
  pkgs,
  ...
}:

let
  username = "htpc";
in
{
  imports = [ ./../../homeManagerModules ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    # Entertainment & Media
    plex-desktop
    vlc
    firefox

    # Nix
    git
  ];

  homeModules = {
    applications = {
      module.enableDefaults = false;
      flex-launcher.enable = true;
    };
    dev.module.enableDefaults = false;
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
