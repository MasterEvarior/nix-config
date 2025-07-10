{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:

let
  secretsDirectory = builtins.toString inputs.my-sops-secrets;
  secretsFilePath = "${secretsDirectory}/secrets.yaml";
  keyFilePath = "/etc/sops/keys.txt";
in
{
  options.modules.sops = {
    enable = lib.mkEnableOption "SOPS";
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
      cfg = config.modules.sops;
    in
    lib.mkIf config.modules.sops.enable {

      environment.systemPackages = with pkgs; [
        sops
        age
      ];

      sops = {
        age.keyFile = cfg.ageKeyFile;

        defaultSopsFile = cfg.defaultSecretsFile;
        validateSopsFiles = false;

        secrets = { } // cfg.secretsToLoad;
      };
    };
}
