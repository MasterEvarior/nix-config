{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.opencode = {
    enable = lib.mkEnableOption "Opencode CLI";
    package = lib.mkPackageOption pkgs "opencode" { };
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
    providers.ollama.enable = lib.mkOption {
      default = config.homeModules.applications.ollama.enable;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to preconfigure OpenCode with the local Ollama provider";
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

      assertions = [
        {
          assertion =
            let
              ollamaEnabled = config.homeModules.applications.ollama.enable;
              providerEnabled = cfg.providers.ollama.enable;
            in
            if providerEnabled then ollamaEnabled else true;
          message = "If the Ollama provider is enable, the Ollama module must be enabled aswell";
        }
      ];

      programs.opencode = {
        inherit (cfg) package;

        enable = true;
        settings = {
          theme = cfg.theme;
          share = cfg.share;
          autoupdate = false;
          provider = {
            ollama = lib.mkIf cfg.providers.ollama.enable {
              npm = "@ai-sdk/openai-compatible";
              "name" = "Ollama (local)";
              "options" = {
                "baseURL" = "http://${config.services.ollama.host}:${toString config.services.ollama.port}/v1";
              };
              "models" = {
                "qwen3.5:2b" = {
                  "name" = "qwen3.5";
                };
              };
            };
          };
        };
      };
    };
}
