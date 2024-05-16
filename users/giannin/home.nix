{pkgs, ...}:

{
  home.username = "giannin";
  home.homeDirectory = "/home/giannin";

  programs.git = {
    enable = true;
    userName = "Giannin";
    userEmail = "contact@giannin.ch";
  };


  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dimensions = {
          lines = 50;
          columns = 150;
        };
        # decorations = "None";
        opacity = 0.95;
        blur = true; #this will only work on macOS and KDE Wayland
      };

      # the theme is inspired by this
      # https://github.com/alacritty/alacritty-theme/blob/master/themes/monokai_charcoal.toml
      colors = {
        primary.background = "#000000";
        primary.foreground = "#FFFFFF";

        normal.black = "#1a1a1a";
        normal.red = "#f4005f";
        normal.green = "#98e024";
        normal.yellow = "#fa8419";
        normal.blue = "#9d65ff";
        normal.magenta = "#f4005f";
        normal.cyan = "#58d1eb";
        normal.white = "#c4c5b5";

        bright.black   = "#625e4c";
        bright.red     = "#f4005f";
        bright.green   = "#98e024";
        bright.yellow  = "#e0d561";
        bright.blue    = "#9d65ff";
        bright.magenta = "#f4005f";
        bright.cyan    = "#58d1eb";
        bright.white   = "#f6f6ef";
      };
    };
  };

  home.packages = with pkgs; [

      # Entertainment & Media
      spotify
      plex-media-player
      vlc

      # Secret Management
      _1password 
      _1password-gui
  ];

  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}