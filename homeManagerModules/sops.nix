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
    ageKeyFile = lib.mkOption {
      default = keyFilePath;
      example = ../sops/age/keys.txt;
      type = lib.types.path;
      description = "Path to the age key file to unlock the secrets";
    };
    defaultSecretsFile = lib.mkOption {
      default = secretsFilePath;
      example = "./secrets.yaml";
      type = lib.types.path;
      description = "Path to your secrets.yaml file";
    };
    secretsToLoad = lib.mkOption {
      default = { };
      example = {
        "your/secret" = { };
      };
      type = lib.types.attrs;
      description = "A set where you can specified secrets to load";
    };
  };

  config =
    let
      cfg = config.homeModules.sops;
    in
    lib.mkIf config.homeModules.sops.enable {
      home.packages = with pkgs; [
        sops
        age
      ];

      sops = {
        age.keyFile = cfg.ageKeyFile;

        defaultSopsFile = "${secretsFilePath}";
        validateSopsFiles = false;

        secrets = { } // cfg.secretsToLoad;
      };
    };
}
