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
  };

  config =
    let
      cfg = config.homeModules.dev.golang;
    in
    lib.mkIf config.homeModules.dev.golang.enable {
      home.packages =
        with pkgs;
        [
          go
        ]
        ++ lib.optionals (cfg.installIDE) [ jetbrains.goland ];
    };

}
