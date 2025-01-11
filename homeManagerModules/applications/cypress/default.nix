{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.cypress = {
    enable = lib.mkEnableOption "E2E-Testing Tool Cypress";
    additionalBrowsers = lib.mkOption {
      default = with pkgs; [
        google-chrome
        firefox
      ];
      example = with pkgs; [
        google-chrome
        firefox
      ];
      type = lib.types.listOf lib.types.package;
      description = "Additional browsers that should be installed for E2E testing";
    };
  };

  config =
    let
      conf = config.homeModules.applications.cypress;
    in
    lib.mkIf config.homeModules.applications.cypress.enable {
      home.packages =
        with pkgs;
        [
          cypress
          steam-run
        ]
        ++ conf.additionalBrowsers;

      home.shellAliases = {
        cypress = "steam-run ${builtins.toString pkgs.cypress}/bin/cypress";
      };
    };
}
