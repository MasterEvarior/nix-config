{
  lib,
  config,
  ...
}:

{
  options.modules.displayManager.sddm.silent-sddm = {
    enable = lib.mkEnableOption "Enable the SilentSDDM theme";
  };

  config = lib.mkIf config.modules.sddm.silent-sddm.enable {
  };
}
