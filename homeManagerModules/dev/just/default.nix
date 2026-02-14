{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.just = {
    enable = lib.mkEnableOption "Just";
    setupVisualStudioCode = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Extensions for VSC that help with writting Just files";
    };
  };

  config =
    let
      cfg = config.homeModules.dev.just;
      optionals = lib.optionals;
    in
    lib.mkIf config.homeModules.dev.just.enable {
      home.packages = with pkgs; [
        just
      ];

      homeModules.applications.vscode.additionalExtensions = optionals (cfg.setupVisualStudioCode) (
        with pkgs;
        [
          vscode-extensions.nefrob.vscode-just-syntax
        ]
      );
    };
}
