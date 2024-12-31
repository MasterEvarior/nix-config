{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  secretsDirectory = builtins.toString inputs.nix-secrets;
  secretsFilePath = "${secretsDirectory}/secrets.yaml";
  homeDirectory = config.home.homeDirectory;
in

{
  options.homeModules.sops = {
    enable = lib.mkEnableOption "Secret Management with SOPS-Nix";
  };

  config = lib.mkIf config.homeModules.sops.enable {
    home.packages = with pkgs; [
      sops
      age
    ];

    sops = {
      age.keyFile = "${homeDirectory}/.config/sops/age/keys.txt";

      defaultSopsFile = "${secretsFilePath}";
      validateSopsFiles = false;
    };
  };
}
