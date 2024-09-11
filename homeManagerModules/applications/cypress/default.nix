{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.cypress = {
    enable = lib.mkEnableOption "E2E-Testing Tool Cypress";
  };

  config = lib.mkIf config.homeModules.cypress.enable {
    home.packages = with pkgs; [
      cypress
      steam-run
    ];

    home.shellAliases = {
      cypress = "steam-run npx cypress";
    };
  };
}