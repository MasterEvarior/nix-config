{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.firefox = {
    enable = lib.mkEnableOption "Firefox";
    makeDefaultBrowser = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Set Firefox as the default browser";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.firefox;
    in
    lib.mkIf config.homeModules.applications.firefox.enable {
      home.packages = with pkgs; [
        firefox
      ];

      xdg = lib.mkIf cfg.makeDefaultBrowser {
        enable = true;
        desktopEntries = {
          firefox = {
            name = "Firefox Web Browser";
            genericName = "Firefox";
            exec = "${pkgs.firefox}/bin/firefox";
            terminal = false;
            categories = [
              "Application"
            ];
            settings = {
              Keywords = "Browser";
            };
          };
        };
        mimeApps = {
          enable = true;
          defaultApplications = {
            "text/html" = "firefox.desktop";
            "x-scheme-handler/http" = "firefox.desktop";
            "x-scheme-handler/https" = "firefox.desktop";
            "x-scheme-handler/about" = "firefox.desktop";
            "x-scheme-handler/unknown" = "firefox.desktop";
          };
        };
      };
    };
}
