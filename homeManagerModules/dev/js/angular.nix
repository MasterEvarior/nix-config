{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.js.angular = {
    enable = lib.mkEnableOption "Angular";
  };

  config = lib.mkIf config.homeModules.dev.js.angular.enable {

    home.packages = with pkgs; [
      angular-language-server
    ];

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.angular.ng-template
    ];

    home.shellAliases = {
      ng-create-new = "npx -p @angular/cli ng new";
      ng-generate = "npx -p @angular/cli ng generate";
    };
  };
}
