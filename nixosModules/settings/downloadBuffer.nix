{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.modules.settings.downloadBuffer = {
    enable = lib.mkEnableOption "Increase download buffer size";
  };

  config = lib.mkIf config.modules.settings.downloadBuffer.enable {
    nix.settings = {
      # Download buffer size in bytes
      # Default is 64MB, this is about double
      # See https://nix.dev/manual/nix/2.28/command-ref/conf-file.html#conf-download-buffer-size
      download-buffer-size = 134217728;
    };
  };
}
