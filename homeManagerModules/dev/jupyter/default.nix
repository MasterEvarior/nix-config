{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.jupyter = {
    enable = lib.mkEnableOption "Jupyter Notebooks";
  };

  config = lib.mkIf config.homeModules.dev.jupyter.enable {

    home.packages = with pkgs; [
      python3
      python311Packages.jupyter-core
    ];

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.ms-toolsai.jupyter
    ];
  };
}
