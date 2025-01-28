{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:

{
  options.homeModules.dev.containerization = {
    enable = lib.mkEnableOption "Containers";
  };

  config = lib.mkIf config.homeModules.dev.containerization.enable {
    assertions = [
      {
        assertion = osConfig.modules.containers.enable;
        message = "Containers need to be enabled at OS level for the dev.containerization home manager module to work";
      }
    ];

    home.packages = with pkgs; [
      lazydocker
    ];

    homeModules.applications.vscode.additionalExtensions = with pkgs; [
      vscode-extensions.ms-azuretools.vscode-docker
    ];

  };
}
