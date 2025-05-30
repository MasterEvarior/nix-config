{
  lib,
  config,
  ...
}:

{
  options.modules.settings.garbageCollection = {
    enable = lib.mkEnableOption "Automatic garbage collection";
    keep = lib.mkOption {
      default = 60;
      example = 60;
      type = lib.types.int;
      description = "How many days an old generation should be kept";
    };
    autoOptimiseStore = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Wether or not to enable auto optimise for the nix-store";
    };
  };

  config =
    let
      cfg = config.modules.settings.garbageCollection;
    in
    lib.mkIf config.modules.settings.garbageCollection.enable {
      nix = {
        settings.auto-optimise-store = cfg.autoOptimiseStore;
        gc = {
          automatic = true;
          dates = "daily";
          options = "--delete-older-than ${toString cfg.keep}d";
        };
      };
    };
}
