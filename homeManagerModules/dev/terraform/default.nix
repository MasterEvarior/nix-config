{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.terraform = {
    enable = lib.mkEnableOption "Terraform";
  };

  config = lib.mkIf config.homeModules.dev.terraform.enable {
    home.packages = with pkgs; [ terraform ];

    homeModules.applications.vscode = {
      additionalExtensions = with pkgs; [ vscode-extensions.hashicorp.terraform ];
    };
  };
}
