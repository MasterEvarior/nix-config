{
  lib,
  config,
  ...
}:

{
  options.homeModules.terminal.oh-my-posh = {
    enable = lib.mkEnableOption "Oh-My-Posh";
  };

  config = lib.mkIf config.homeModules.terminal.oh-my-posh.enable {
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
        upgrade = {
          notice = false;
        };

        # https://github.com/JanDeDobbeleer/oh-my-posh/issues/5310
        disable_notice = true;
        auto_upgrade = false;

        version = 2;
      };
    };
  };
}
