{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.js.vue = {
    enable = lib.mkEnableOption "Vue";
  };

  config = lib.mkIf config.homeModules.dev.js.vue.enable {
    home.packages = with pkgs; [
      vue-language-server
    ];

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.vue.volar
    ];
  };
}
