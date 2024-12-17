{
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./angular.nix
    ./react.nix
    ./vue.nix
  ];

  options.homeModules.dev.js = {
    enable = lib.mkEnableOption "JS support";
    typescript.enable = lib.mkEnableOption "TS support";
  };

  config =
    let
      cfg = config.homeModules.dev.js;
    in
    lib.mkIf cfg.enable {
      home.packages =
        with pkgs;
        [ nodejs_22 ]
        ++ lib.lists.optionals (cfg.typescript.enable) [
          typescript
          typescript-language-server
        ];

      homeModules.applications.vscode = {
        additionalExtensions = with pkgs; [
          vscode-extensions.esbenp.prettier-vscode
          vscode-extensions.dbaeumer.vscode-eslint
          vscode-extensions.usernamehw.errorlens
          vscode-extensions.editorconfig.editorconfig
        ];

        additionalUserSettings = {
          "[html]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.formatOnSave" = true;
          };
          "[javascript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.formatOnSave" = true;
          };
          "[typescript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.formatOnSave" = true;
          };
        };
      };

    };
}
