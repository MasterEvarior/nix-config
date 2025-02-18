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
        [
          nodejs_22
          nodemon
          yarn
        ]
        ++ lib.lists.optionals (cfg.typescript.enable) [
          typescript-language-server
        ]
        ++ lib.lists.optionals (cfg.typescript.enable && !cfg.angular.enable) [
          typescript
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
          "[css]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.formatOnSave" = true;
          };
          "javascript.updateImportsOnFileMove.enabled" = "always";
        };
      };

      homeModules.applications.treefmt.additionalFormatters = with pkgs; [
        {
          name = "prettier";
          command = "prettier";
          options = [ "--write" ];
          includes = [
            "*.cjs"
            "*.css"
            "*.html"
            "*.js"
            "*.jsx"
            "*.mdx"
            "*.mjs"
            "*.scss"
            "*.ts"
            "*.tsx"
            "*.vue"
          ];
          package = nodePackages.prettier;
        }
      ];
    };
}
