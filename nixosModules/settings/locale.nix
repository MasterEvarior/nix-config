{lib, ...}:

{
  time.timeZone = lib.mkDefault "Europe/Zurich";

  i18n = {
    defaultLocale = lib.mkDefault "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = lib.mkDefault "de_CH.UTF-8";
      LC_IDENTIFICATION = lib.mkDefault "de_CH.UTF-8";
      LC_MEASUREMENT = lib.mkDefault "de_CH.UTF-8";
      LC_MONETARY = lib.mkDefault "de_CH.UTF-8";
      LC_NAME = lib.mkDefault "de_CH.UTF-8";
      LC_NUMERIC = lib.mkDefault "de_CH.UTF-8";
      LC_PAPER = lib.mkDefault "de_CH.UTF-8";
      LC_TELEPHONE = lib.mkDefault "de_CH.UTF-8";
      LC_TIME = lib.mkDefault "de_CH.UTF-8";
    };
  };

}
