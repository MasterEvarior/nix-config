{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.mako = {
    enable = lib.mkEnableOption "Mako";
    theme = lib.mkOption {
      example = {
        text = "#cad3f5";
        subtext1 = "#b8c0e0";
        subtext0 = "#a5adcb";
        overlay2 = "#939ab7";
      };
      type = lib.types.attrs;
      description = "Theme";
    };
  };

  config =
    let
      theme = config.homeModules.desktop.sway.mako.theme;
    in
    lib.mkIf config.homeModules.desktop.sway.mako.enable {
      home.packages = with pkgs; [
        mako
      ];

      home.file.".config/mako/config".text = ''
        background-color=${theme.base}
        text-color=${theme.text}
        border-color=${theme.rosewater}
        progress-color=over ${theme.surface0}

        [urgency=high]
        border-color=${theme.pink}
      '';

      homeModules.desktop.sway.additionalStartupCommands = [
        {
          command = "${pkgs.mako}/bin/mako";
        }
      ];
    };
}
