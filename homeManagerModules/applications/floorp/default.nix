{
  lib,
  config,
  ...
}:

{
  options.homeModules.applications.floorp = {
    enable = lib.mkEnableOption "Floorp";
  };

  config = lib.mkIf config.homeModules.applications.floorp.enable {

    programs.floorp = {
      enable = true;
      languagePacks = [
        "en-GB"
        "de-CH"
      ];
    };

  };
}
