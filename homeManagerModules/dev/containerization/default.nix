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
    delegateComposeBuilds = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to delegate builds for Docker Compose to Bake for improved performance";
    };
  };

  config =
    let
      cfg = config.homeModules.dev.containerization;
    in
    lib.mkIf config.homeModules.dev.containerization.enable {
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

      home.sessionVariables = {
        COMPOSE_BAKE = (toString cfg.delegateComposeBuilds);
      };

    };
}
