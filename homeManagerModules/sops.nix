{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:

let
  secretsDirectory = builtins.toString inputs.my-sops-secrets;
  secretsFilePath = "${secretsDirectory}/secrets.yaml";
  homeDirectory = config.home.homeDirectory;
  keyFilePath = "${homeDirectory}/.config/sops/age/keys.txt";
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
      age.keyFile = keyFilePath;

      defaultSopsFile = "${secretsFilePath}";
      validateSopsFiles = false;

      secrets."b2_backup/passphrase" = { };
    };
  };
}
