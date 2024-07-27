{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    modules.dev.nix.enable = lib.mkEnableOption "Nix module";
  };

  config = lib.mkIf config.modules.dev.java.enable {
    environment.systemPackages = with pkgs; [
      nixfmt-rfc-style
      nixd
    ];
  };
}
