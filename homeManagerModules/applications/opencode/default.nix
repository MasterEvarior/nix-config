{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.opencode = {
    enable = lib.mkEnableOption "Opencode CLI";
    share = lib.mkOption {
      default = "disabled";
      example = "disabled";
      type = lib.types.enum [
        "manual"
        "auto"
        "disabled"
      ];
      description = "See here: https://opencode.ai/docs/config/#sharing";
    };
    theme = lib.mkOption {
      default = "catppuccin-macchiato";
      example = "catppuccin";
      type = lib.types.enum [
        "system"
        "tokyonight"
        "everforest"
        "ayu"
        "catppuccin"
        "catppuccin-macchiato"
        "gruvbox"
        "kanagawa"
        "nord"
        "matrix"
        "one-dark"
      ];
      description = "See here: https://opencode.ai/docs/themes";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.opencode;
    in
    lib.mkIf config.homeModules.applications.opencode.enable {
      programs.opencode = {
        enable = true;
        settings = {
          theme = cfg.theme;
          share = cfg.share;
          plugin = [
            "opencode-gemini-auth@latest"
          ];
          autoupdate = false;
        };
      };
    };
}
