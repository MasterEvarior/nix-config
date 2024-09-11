{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.cypress = {
    enable = lib.mkEnableOption "E2E-Testing Tool Cypress";
  };

  config = lib.mkIf config.homeModules.applications.cypress.enable {
    home.packages = with pkgs; [
      cypress
      steam-run
    ];

    home.shellAliases = {
      cypress = "steam-run npx cypress";
    };
  };
}
