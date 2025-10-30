{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.helix = {
    enable = lib.mkEnableOption "A post-modern text editor.";
    theme = lib.mkOption {
      default = "catppuccin-macchiato";
      example = "catppuccin-macchiato";
      type = lib.types.enum [
        "default"
        "base16"
        "catppuccin-macchiato"
      ];
      description = "Which theme to choose";
    };
    languageServers = lib.mkOption {
      default = [ ];
      description = "List of language servers";
      type = lib.types.listOf (
        lib.types.attrsOf (
          lib.types.submodule {
            options = with lib.types; {
              command = lib.mkOption {
                example = "mylang-lsp";
                type = str;
                description = "The name or path of the language server binary to execute.";
              };
              args = lib.mkOption {
                default = [ ];
                example = [
                  "--stdio"
                ];
                type = listOf str;
                description = "A list of arguments to pass to the language server binary";
              };
              timeout = lib.mkOption {
                default = 20;
                example = 20;
                type = ints.positive;
                description = "The maximum time a request to the language server may take, in seconds. ";
              };
            };
          }
        )
      );
    };
    languages = lib.mkOption {
      default = { };
      description = "List of languages";
      type = lib.types.listOf (
        lib.types.submodule {
          name = lib.mkOption {
            example = "rust";
            type = lib.types.str;
            description = "The name of the language";
          };
          scope = lib.mkOption {
            example = "source.js";
            type = lib.types.str;
            description = ''
              A string like source.js that identifies the language. 
              Currently, we strive to match the scope names used by popular TextMate grammars and by the Linguist library. 
              Usually source.<name> or text.<name> in case of markup languages
            '';
          };
          comment-tokens = lib.mkOption {
            default = [ ];
            example = [
              "//"
              "///"
            ];
            type = lib.types.listOf lib.types.str;
            description = ''
              The tokens to use as a comment token, either a single token "//" or an array ["//", "///", "//!"] (the first token will be used for commenting). 
              Also configurable as comment-token for backwards compatibility
            '';
          };
        }
      );
    };
    additionalPackages = lib.mkOption {
      default = [ ];
      example = [
        pkgs.marksman
      ];
      type = lib.types.listOf lib.types.package;
      description = "Extra packages available to hx.";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.helix;
    in
    lib.mkIf config.homeModules.applications.helix.enable {
      programs.helix = {
        enable = true;
        themes = {
          catppuccin-macchiato = (lib.importTOML ./assets/catppuccin_macchiato.toml);
        };
        settings = {
          theme = cfg.theme;
        };
        languages = {
          language-server = (builtins.foldl' lib.recursiveUpdate { } cfg.languageServers);
        };
        extraPackages = cfg.additionalPackages;
      };
    };
}
