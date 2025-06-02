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
    home.packages = with pkgs; [
      terraform
      terraformer
    ];

    homeModules.applications.vscode = {
      additionalExtensions = with pkgs; [ vscode-extensions.hashicorp.terraform ];
    };

    homeModules.applications.treefmt.additionalFormatters = with pkgs; [
      {
        name = "terraform";
        command = "tofu";
        includes = [
          "*.tf"
          "*.tfvars"
          "*.tftest.hcl"
        ];
        options = [ "fmt" ];
        package = opentofu;
      }
    ];
  };
}
