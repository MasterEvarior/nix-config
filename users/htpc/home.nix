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
    plex-media-player
    vlc
  ];

  homeModules = {
    applications = {
      vscode.enable = false;
      "1password".enable = false;
      spotify.enable = false;
      comma.enable = false;
      fzf.enable = false;
      treefmt.enable = false;
    };
    dev = {
      js = {
        enable = false;
        typescript.enable = false;
      };
      java.enable = false;
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
