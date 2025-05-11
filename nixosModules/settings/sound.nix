{
  lib,
  config,
  ...
}:

{
  options.modules.settings.sound = {
    enable = lib.mkEnableOption "Sound";
  };

  config = lib.mkIf config.modules.settings.sound.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
    };
  };
}
