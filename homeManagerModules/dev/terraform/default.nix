{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.terraform = {
    enable = lib.mkEnableOption "Terraform";
    package = lib.mkPackageOption pkgs "terraform" { };
  };

  config =
    let
      cfg = config.homeModules.dev.terraform;
    in
    lib.mkIf config.homeModules.dev.terraform.enable {
      home = {
        shellAliases = {
          tf = lib.getExe cfg.package;
        };

        packages = [ cfg.package ];
      };

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
