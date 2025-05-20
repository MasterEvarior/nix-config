{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.zathura = {
    enable = lib.mkEnableOption "Zathura";
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
        package = pkgs.zathura;
        mappings = {
          "<Right>" = "navigate next";
          "<Left>" = "navigate previous";
        };
      };

      xdg = {
        enable = true;
        desktopEntries = lib.mkIf cfg.createDesktopEntry {
          zathura = {
            name = "PDF Viewer";
            genericName = "PDF Viewer";
            exec = "${pkgs.zathura}/bin/zathura";
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
