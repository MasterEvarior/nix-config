{
  lib,
  config,
  pkgs-unstable,
  ...
}:

{
  options.homeModules.dev.slidev = {
    enable = lib.mkEnableOption "Presentation Slides for Developers ";
    package = lib.mkPackageOption pkgs-unstable "slidev-cli" { };
    setupVisualStudioCode = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Extensions for VSC that help with Slidev development";
    };
  };

  config =
    let
      cfg = config.homeModules.dev.slidev;
      optionals = lib.optionals;
    in
    lib.mkIf config.homeModules.dev.slidev.enable {
      home.packages = [
        cfg.package
      ];

      homeModules.applications.vscode.additionalExtensions = optionals (cfg.setupVisualStudioCode) [
        pkgs-unstable.vscode-extensions.antfu.slidev
      ];
    };
}
