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
    maxItems = lib.mkOption {
      default = 100;
      example = 100;
      type = lib.types.ints.positive;
      description = "Maximum number of items to store";
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

      home.file.".config/cliphist/config".text = ''
        max-items 1000
      '';

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
