{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.codesnap = {
    enable = lib.mkEnableOption "Codesnap";
  };

  config = lib.mkIf config.homeModules.applications.codesnap.enable {

    home.packages = with pkgs; [
      codesnap
    ];

    home.file.config = {
      enable = true;
      target = ".config/CodeSnap/config.json";
      text = builtins.toJSON {
        theme = "candy";
        window = {
          "mac_window_bar" = true;
          shadow = {
            radius = 20;
            color = "#00000040";
          };
          margin = {
            x = 82;
            y = 82;
          };
          border = {
            width = 1;
            color = "#ffffff30";
          };
        };
        "code_config" = {
          "font_family" = "CaskaydiaCove Nerd Font";
          breadcrumbs = {
            separator = "/";
            color = "#80848b";
            "font_family" = "CaskaydiaCove Nerd Font";
          };
        };
        background = {
          start = {
            x = 0;
            y = 0;
          };
          end = {
            x = "max";
            y = 0;
          };
          stops = [
            {
              position = 0;
              color = "#6bcba5";
            }
            {
              position = 1;
              color = "#caf4c2";
            }
          ];
        };
      };
    };
  };
}
