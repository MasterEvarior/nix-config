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
          gotools
          golangci-lint
        ]
        ++ optionals (cfg.installIDE) [ jetbrains.goland ];

      homeModules.applications = {
        vscode = {
          additionalUserSettings = {
            "go.lintTool" = "golangci-lint";
            "go.lintFlags" = [
              "--fast"
            ];
          };

          additionalExtensions = optionals (cfg.setupVisualStudioCode) [
            pkgs.vscode-extensions.golang.go
          ];
        };

        treefmt.additionalFormatters = with pkgs; [
          {
            name = "golang";
            command = "golangci-lint";
            includes = [
              "*.go"
            ];
            options = [ "run" ];
            package = golangci-lint;
          }
        ];
      };

    };

}
