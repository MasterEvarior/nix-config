{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.js = {
    enable = lib.mkEnableOption "JS/TS/Angular/...";
  };

  config = lib.mkIf config.homeModules.dev.js.enable {
    home.packages = with pkgs; [ nodejs_22 ];

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.angular.ng-template
      vscode-extensions.esbenp.prettier-vscode
      vscode-extensions.dbaeumer.vscode-eslint
      vscode-extensions.usernamehw.errorlens
      vscode-extensions.editorconfig.editorconfig
    ];
  };
}
