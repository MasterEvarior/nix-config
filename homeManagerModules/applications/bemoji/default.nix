{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.bemoji = {
    enable = lib.mkEnableOption "Bemoji";
    createDesktopEntry = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Create desktop entry";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.bemoji;
    in
    lib.mkIf config.homeModules.applications.bemoji.enable {
      home.packages = with pkgs; [
        bemoji

        # Runtime Dependencies
        wl-clipboard
        wtype
      ];

      xdg = lib.mkIf cfg.createDesktopEntry {
        enable = true;
        desktopEntries = {
          bemojiType = {
            name = "Bemoji - Type";
            exec = "${pkgs.bemoji}/bin/bemoji -t";
            terminal = false;
            categories = [
              "Application"
            ];
            settings = {
              Keywords = "emoji";
            };
          };
          bemojiCopy = {
            name = "Bemoji - Copy";
            exec = "${pkgs.bemoji}/bin/bemoji -c";
            terminal = false;
            categories = [
              "Application"
            ];
            settings = {
              Keywords = "emoji";
            };
          };
        };
      };
    };
}
