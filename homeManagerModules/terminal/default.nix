{
  config,
  lib,
  pkgs,
  ...
}:

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
      '';
    };

    programs.oh-my-posh = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        "$schema" = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json";
        blocks = [
          {
            alignment = "left";
            segments = [
              {
                type = "session";
                style = "diamond";
                foreground = "#ffffff";
                background = "#8800dd";
                trailing_diamond = "";
                template = "{{ if .Root }}⚠{{ end }}{{ .UserName }}@{{ .HostName }}";
              }
              {
                background = "#29315A";
                foreground = "#3EC669";
                properties = {
                  style = "folder";
                };
                style = "diamond";
                template = "{{ .Path }}";
                trailing_diamond = "";
                type = "path";
              }
              {
                background = "#e3e3e3";
                foreground = "#242526";
                properties = {
                  branch_max_length = 25;
                  fetch_stash_count = true;
                  fetch_status = true;
                  fetch_upstream_icon = true;
                };
                style = "diamond";
                template = "{{ .UpstreamIcon }}{{ .HEAD }} {{ if gt .Ahead 0}}{{ .Ahead }}⇈{{ end }} {{ if gt .Behind 0}}{{ .Behind }}⇊{{ end }}";
                trailing_diamond = "";
                type = "git";
              }
              {
                foreground = "#C94A16";
                style = "plain";
                template = "{{ if eq .Code 0 }}{{ else }}❌{{ end }}";
                type = "status";
                properties = {
                  always_enabled = true;
                };
              }
            ];
            type = "prompt";
          }
          {
            alignment = "right";
            segments = [
              {
                type = "executiontime";
                style = "diamond";
                foreground = "#ffffff";
                background = "#8800dd";
                template = "⏲ {{ .FormattedMs }} ";
                properties = {
                  threshold = 500;
                  style = "austin";
                  always_enabled = true;
                };
              }
            ];
            type = "prompt";
          }
          {
            alignment = "left";
            newline = true;
            segments = [
              {
                foreground = "#63F08C";
                style = "plain";
                template = "➜ ";
                type = "text";
              }
            ];
            type = "prompt";
          }
        ];
        version = 2;
      };
    };

    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          dimensions = {
            lines = 50;
            columns = 150;
          };
          #decorations = "none";
          opacity = 0.5;
          blur = true; # this will only work on macOS and KDE Wayland
        };

        mouse = {
          hide_when_typing = true;
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
