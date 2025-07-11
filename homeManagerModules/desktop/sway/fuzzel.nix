{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.fuzzel = {
    enable = lib.mkEnableOption "Fuzzel";
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
      theme = config.homeModules.desktop.sway.fuzzel.theme;
      stripHashtag = lib.strings.stringAsChars (x: if x == "#" then "" else x);
      ff = color: "${stripHashtag color}ff";
      dd = color: "${stripHashtag color}dd";
    in
    lib.mkIf config.homeModules.desktop.sway.fuzzel.enable {
      home.packages = with pkgs; [
        fuzzel
      ];

      home.file.".config/fuzzel/fuzzel.ini".text = ''
        [colors]
        background=${dd theme.base}
        text=${ff theme.text}
        prompt=${ff theme.subtext0}
        placeholder=${ff theme.overlay1}
        input=${ff theme.text}
        match=${ff theme.rosewater}
        selection=${ff theme.surface2}
        selection-text=${ff theme.text}
        selection-match=${ff theme.rosewater}
        counter=${ff theme.overlay1}
        border=${ff theme.rosewater}

        [main]
        use-bold=true
      '';

      homeModules.desktop.sway.additionalKeybindings = {
        "+d" = "exec --no-startup-id ${pkgs.fuzzel}/bin/fuzzel";
      };

      homeModules.desktop.sway.bzmenu.launcher = "fuzzel";
    };
}
