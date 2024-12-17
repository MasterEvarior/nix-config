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
    enable = lib.mkEnableOption "JS/TS/...";
  };

  config = lib.mkIf config.homeModules.dev.js.enable {
    home.packages = with pkgs; [ nodejs_22 ];

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
      };
    };

  };
}
