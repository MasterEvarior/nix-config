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

    homeModules.dev.python = {
      enable = true;
      additionalPackages = with pkgs.python311Packages; [
        pip
        ipykernel
        notebook
        mpmath
      ];
    };

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.ms-toolsai.jupyter
    ];
  };
}
