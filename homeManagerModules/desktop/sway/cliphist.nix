{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.cliphist = {
    enable = lib.mkEnableOption "Enable cliphist";
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
      home.packages = with pkgs; [
        cliphist
      ];

      homeModules.desktop.sway =
        let
          cliphistBin = "${pkgs.cliphist}/bin/cliphist";
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
