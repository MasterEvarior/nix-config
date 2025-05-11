{
  lib,
  config,
  ...
}:

{
  options.modules.settings.unfree = {
    enable = lib.mkEnableOption "Unfree packages";
  };

  config = lib.mkIf config.modules.settings.unfree.enable {
    nixpkgs.config.allowUnfree = true;
  };
}
