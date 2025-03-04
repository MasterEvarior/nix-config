{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.golang = {
    enable = lib.mkEnableOption "Golang";
    installIDE = lib.mkEnableOption "GoLand";
    setupVisualStudioCode = lib.mkEnableOption "Extensions for VSC that help with Golang development";
  };

  config =
    let
      cfg = config.homeModules.dev.golang;
      optionals = lib.optionals;
    in
    lib.mkIf config.homeModules.dev.golang.enable {
      home.packages =
        with pkgs;
        [
          go
        ]
        ++ optionals (cfg.installIDE) [ jetbrains.goland ];

      homeModules.applications.vscode.additionalExtensions = optionals (cfg.setupVisualStudioCode) [
        pkgs.vscode-extensions.golang.go
      ];
    };

}
