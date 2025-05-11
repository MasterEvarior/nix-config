{
  lib,
  config,
  ...
}:

{
  options.modules.settings.locale = {
    enable = lib.mkEnableOption "Locale";
    timeZone = lib.mkOption {
      default = "Europe/Zurich";
      example = "Europe/Zurich";
      type = lib.types.str;
      description = "Timezone";
    };
    language = lib.mkOption {
      default = "en_GB.UTF-8";
      example = "en_GB.UTF-8";
      type = lib.types.str;
      description = "In which locale the OS language should be";
    };
    extra = lib.mkOption {
      default = "de_CH.UTF-8";
      example = "de_CH.UTF-8";
      type = lib.types.str;
      description = "In which locale things like dates, time, etc. should be";
    };
  };

  config =
    let
      cfg = config.modules.settings.locale;
      language = lib.mkDefault cfg.language;
      extra = lib.mkDefault cfg.extra;
    in
    lib.mkIf config.modules.settings.locale.enable {
      time.timeZone = lib.mkDefault cfg.timeZone;

      i18n = {
        defaultLocale = language;
        extraLocaleSettings = {
          LC_ADDRESS = extra;
          LC_IDENTIFICATION = extra;
          LC_MEASUREMENT = extra;
          LC_MONETARY = extra;
          LC_NAME = extra;
          LC_NUMERIC = extra;
          LC_PAPER = extra;
          LC_TELEPHONE = extra;
          LC_TIME = extra;
        };
      };
    };
}
