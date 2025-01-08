{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.just = {
    enable = lib.mkEnableOption "Just";
  };

  config = lib.mkIf config.homeModules.dev.just.enable {
    home.packages = with pkgs; [
      just
    ];

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.nefrob.vscode-just-syntax
    ];
  };
}
