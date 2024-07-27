{ config, lib, ... }:

{
  options.homeModules.terminal = {
    enable = lib.mkEnableOption "shell and terminal configuration";
  };

  config = lib.mkIf config.homeModules.terminal.enable {
    programs.zsh = {
      enable = true;
      initExtra = ''
        # initExtra

        # enables autocompletion and the key-based interface
        autoload -Uz compinit
        compinit
        zstyle ':completion:*' menu select

        autoload -U colors && colors

        autoload -Uz add-zsh-hook vcs_info
        setopt prompt_subst
        add-zsh-hook precmd vcs_info
        zstyle ':vcs_info:git:*' formats '%b'

        PROMPT='%F{green}%T %F{blue}%~ %F{yellow} ''${vcs_info_msg_0_}%f%F{white}> '
      '';
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
          blur = true; # this will only work on macOS and KDE Wayland
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

          bright.black = "#625e4c";
          bright.red = "#f4005f";
          bright.green = "#98e024";
          bright.yellow = "#e0d561";
          bright.blue = "#9d65ff";
          bright.magenta = "#f4005f";
          bright.cyan = "#58d1eb";
          bright.white = "#f6f6ef";
        };
      };
    };
  };
}
