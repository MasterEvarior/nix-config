{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.c = {
    enable = lib.mkEnableOption "C/C++";
    installCLion = lib.mkEnableOption "Install CLion from Jetbrains";
  };

  config =
    let
      cfg = config.homeModules.dev.c;
    in
    lib.mkIf config.homeModules.dev.c.enable {
      home.packages =
        with pkgs;
        [
          gcc
          gnumake
        ]
        ++ lib.lists.optionals (cfg.installCLion) [
          jetbrains.clion
        ];

      homeModules.applications.vscode.additionalExtensions = [
        pkgs.vscode-extensions.ms-vscode.cpptools
      ];
    };
}
