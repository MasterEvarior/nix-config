{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.settings.fingerprint = {
    enable = lib.mkEnableOption "Fingerprint reader for auth";
  };

  config = lib.mkIf config.modules.settings.fingerprint.enable {
    services.fprintd.enable = true;
  };
}
