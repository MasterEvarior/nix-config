{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.ruby = {
    enable = lib.mkEnableOption "Ruby";
  };

  config = lib.mkIf config.homeModules.dev.ruby.enable {
    home.packages = with pkgs; [
      ruby
      ruby-lsp
    ];

    homeModules.applications.vscode.additionalExtensions = with pkgs.vscode-extensions; [
      shopify.ruby-lsp
    ];
  };
}
