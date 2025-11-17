{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.zathura = {
    enable = lib.mkEnableOption "Zathura";
    package = lib.mkPackageOption pkgs "zathura" { };
    createDesktopEntry = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Create desktop entry";
    };
    makeDefaultApplication = lib.mkEnableOption "Make default per XDG settings";
  };

  config =
    let
      cfg = config.homeModules.applications.zathura;
    in
    lib.mkIf config.homeModules.applications.zathura.enable {

      programs.zathura = {
        enable = true;
        package = cfg.package;
        mappings = {
          "<Right>" = "navigate next";
          "<Left>" = "navigate previous";
        };
        options = {
          "selection-clipboard" = "clipboard";
        };
      };

      home.shellAliases = {
        pdfviewer = lib.getExe cfg.package;
      };

      xdg = {
        enable = true;
        desktopEntries = lib.mkIf cfg.createDesktopEntry {
          zathura = {
            name = "PDF Viewer";
            genericName = "PDF Viewer";
            exec = lib.getExe cfg.package;
            terminal = false;
            categories = [
              "Application"
            ];
            settings = {
              Keywords = "PDF";
            };
          };
        };
        mimeApps = lib.mkIf cfg.makeDefaultApplication {
          enable = true;
          defaultApplications = {
            "application/pdf" = [ "zathura.desktop" ];
          };
        };
      };
    };
}
