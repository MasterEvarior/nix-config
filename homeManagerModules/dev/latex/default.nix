{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.latex = {
    enable = lib.mkEnableOption "Latex";
  };

  config = lib.mkIf config.homeModules.dev.latex.enable {
    home.packages = with pkgs; [
      texliveFull
    ];

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.james-yu.latex-workshop
    ];

  };
}
