{
  lib,
  config,
  ...
}:

{
  options.modules.settings.flakes = {
    enable = lib.mkEnableOption "Flakes";
  };

  config = lib.mkIf config.modules.settings.flakes.enable {
    # Enable flakes https://nixos.wiki/wiki/Flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
