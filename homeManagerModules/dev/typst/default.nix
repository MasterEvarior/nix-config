{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.typst = {
    enable = lib.mkEnableOption "Typst";
  };

  config = lib.mkIf config.homeModules.dev.typst.enable {
    home.packages = with pkgs; [
      typst
      typstfmt
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

    homeModules.applications.treefmt.additionalFormatters = with pkgs; [
      {
        name = "typstfmt";
        command = "typstfmt";
        includes = [
          "*.typ"
          "*.typst"
        ];
        options = [ "--edit" ];
        package = typstfmt;
      }
    ];

    home.file.templates = {
      recursive = true;
      source = ./assets/templates;
      target = ".local/share/typst/packages/local";
    };

  };
}
