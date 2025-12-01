{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.typst = {
    enable = lib.mkEnableOption "Typst";
    fmt.package = lib.mkPackageOption pkgs "typstyle" { };
  };

  config =
    let
      cfg = config.homeModules.dev.typst;
    in
    lib.mkIf config.homeModules.dev.typst.enable {
      home.packages = with pkgs; [
        typst
        tinymist
        cfg.fmt.package
      ];

      homeModules.applications.vscode = {
        additionalExtensions = with pkgs; [ vscode-extensions.myriad-dreamin.tinymist ];
        additionalSnippets = {
          typst = {
            "Create import template" = {
              prefix = [ "imp" ];
              description = "Create an import template for typst";
              body = [ "#import \"@\${1|preview,local|}/$2:$3\":$4" ];
            };
          };
        };
        additionalUserSettings = {
          "[typst]" = {
            "editor.formatOnSave" = true;
          };
        };
      };

      homeModules.applications.treefmt.additionalFormatters = [
        {
          name = cfg.fmt.package.pname;
          command = "${lib.getExe cfg.fmt.package}";
          includes = [
            "*.typ"
            "*.typst"
          ];
          options = [ "--edit" ];
          package = cfg.fmt.package;
        }
      ];

      home.file.templates = {
        recursive = true;
        source = ./assets/templates;
        target = ".local/share/typst/packages/local";
      };

    };
}
