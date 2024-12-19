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
                background = "#f38ba8";
                foreground = "#FFFFFF";
                trailing_diamond = "";
                template = "{{ if .Root }}⚠{{ end }}{{ .UserName }}@{{ .HostName }}";
              }
              {
                foreground = "#11111b";
                background = "#89b4fa";
                properties = {
                  style = "folder";
                };
                style = "diamond";
                template = "{{ .Path }}";
                trailing_diamond = "";
                type = "path";
              }
              {
                background = "#FFFFFF";
                foreground = "#11111b";
                properties = {
                  branch_max_length = 25;
                  fetch_stash_count = true;
                  fetch_status = true;
                  fetch_upstream_icon = true;
                };
                style = "diamond";
                template = " {{ .UpstreamIcon }}{{ .HEAD }} {{ if gt .Ahead 0}}{{ .Ahead }}⤒{{ end }} {{ if gt .Behind 0}}{{ .Behind }}⤓{{ end }}";
                trailing_diamond = "";
                type = "git";
              }
              {
                foreground = "#FFFFFF";
                background = "#f38ba8";
                style = "diamond";
                template = "{{ if eq .Code 0 }}{{ else }}Error{{ end }}";
                type = "status";
                trailing_diamond = "";
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
                foreground = "#11111b";
                background = "#a6e3a1";
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
        upgrade =  {
          notice = false;
        };
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
          #opacity = 0.5;
          blur = true; # this will only work on macOS and KDE Wayland
        };

        mouse = {
          hide_when_typing = true;
        };

        # the theme is catppuccin mocha
        # https://github.com/catppuccin/alacritty/blob/main/catppuccin-mocha.toml
        colors = {
          primary = {
            background = "#1e1e2e";
            foreground = "#cdd6f4";
            dim_foreground = "#7f849c";
            bright_foreground = "#cdd6f4";
          };
          cursor = {
            text = "#1e1e2e";
            cursor = "#f5e0dc";
          };
          vi_mode_cursor = {
            text = "#1e1e2e";
            cursor = "#b4befe";
          };
          search = {
            matches = {
              foreground = "#1e1e2e";
              background = "#a6adc8";
            };
            focused_match = {
              foreground = "#1e1e2e";
              background = "#a6e3a1";
            };
          };
          footer_bar = {
            foreground = "#1e1e2e";
            background = "#a6adc8";
          };
          hints = {
            start = {
              foreground = "#1e1e2e";
              background = "#f9e2af";
            };
            end = {
              foreground = "#1e1e2e";
              background = "#a6adc8";
            };
          };
          selection = {
            text = "#1e1e2e";
            background = "#f5e0dc";
          };
          normal = {
            black = "#45475a";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#89b4fa";
            magenta = "#f5c2e7";
            cyan = "#94e2d5";
            white = "#bac2de";
          };
          bright = {
            black = "#585b70";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#89b4fa";
            magenta = "#f5c2e7";
            cyan = "#94e2d5";
            white = "#a6adc8";
          };
          dim = {
            black = "#45475a";
            red = "#f38ba8";
            green = "#a6e3a1";
            yellow = "#f9e2af";
            blue = "#89b4fa";
            magenta = "#f5c2e7";
            cyan = "#94e2d5";
            white = "#bac2de";
          };
          indexed_colors = [
            {
              index = 16;
              color = "#fab387";
            }
            {
              index = 17;
              color = "#f5e0dc";
            }
          ];
        };
      };
    };
  };
}
