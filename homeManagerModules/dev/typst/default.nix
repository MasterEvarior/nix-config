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
      additionalUserSettings = {
        "[typst]" = {
          "editor.formatOnSave" = true;
        };
      };
    };

  };
}
