{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.python = {
    enable = lib.mkEnableOption "Python";
    setupVisualStudioCode = lib.mkEnableOption "Extensions for VSC that help with Python development";
    additionalPackages = lib.mkOption {
      default = [ ];
      example = [
        pkgs.python311Packages.pip
        pkgs.python311Packages.ipykernel
      ];
      type = lib.types.listOf lib.types.package;
      description = "A list of packages you want to install additionally";
    };
  };

  config =
    let
      optionals = lib.optionals;
      cfg = config.homeModules.dev.python;
    in
    lib.mkIf config.homeModules.dev.python.enable {
      home.packages = with pkgs; [
        (python3.withPackages (_pythonPkgs: config.homeModules.dev.python.additionalPackages))
      ];

      homeModules.applications = {
        vscode = {
          additionalUserSettings = {
            "[python]" = {
              "editor.defaultFormatter" = "ms-python.black-formatter";
              "editor.formatOnSave" = true;
            };
          };

          additionalExtensions = optionals (cfg.setupVisualStudioCode) [
            pkgs.vscode-extensions.ms-python.python
            pkgs.vscode-extensions.ms-python.debugpy
            pkgs.vscode-extensions.ms-python.black-formatter
          ];
        };

        treefmt.additionalFormatters = with pkgs; [
          {
            name = "black";
            command = "black";
            includes = [
              "*.py"
              "*.pyi"
            ];
            package = black;
          }
        ];
      };
    };
}
