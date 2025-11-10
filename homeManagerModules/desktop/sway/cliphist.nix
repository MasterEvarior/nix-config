{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.cliphist = {
    enable = lib.mkEnableOption "Enable cliphist";
    package = lib.mkPackageOption pkgs "cliphist" { };
    dmenuCommand = lib.mkOption {
      example = "fuzzel --dmenu";
      type = lib.types.str;
      description = "Command to execute, to display a dmenu like menu";
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway.cliphist;
    in
    lib.mkIf config.homeModules.desktop.sway.cliphist.enable {
      home.packages = [
        pkgs.wl-clipboard
        cfg.package
      ];

      homeModules.desktop.sway =
        let
          cliphistBin = (lib.getExe cfg.package);
        in
        {
          additionalKeybindings = {
            "+c exec" = "${cliphistBin} list | ${cfg.dmenuCommand} | ${cliphistBin} decode | wl-copy";
          };
          additionalStartupCommands = [
            {
              command = "wl-paste --watch ${cliphistBin} store";
              always = true;
            }
          ];
        };
    };
}
