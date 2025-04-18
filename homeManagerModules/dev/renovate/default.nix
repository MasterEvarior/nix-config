{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.renovate = {
    enable = lib.mkEnableOption "Renovate";
    installCli = lib.mkEnableOption "Renovate Cli";
  };

  config =
    let
      cfg = config.homeModules.dev.renovate;
      optionals = lib.optionals;
    in
    lib.mkIf config.homeModules.dev.renovate.enable {
      home.packages = optionals (cfg.installCli) (
        with pkgs;
        [
          renovate
        ]
      );

      home.shellAliases = {
        renovate-init = "echo '${builtins.readFile ./assets/template.json}' > renovate.json";
      };
    };
}
