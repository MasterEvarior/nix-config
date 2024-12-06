{
  lib,
  config,
  ...
}:

{
  options.modules.settings.shebang = {
    enable = lib.mkEnableOption "Filesystem for /bin PATH wrapper";
  };

  config = lib.mkIf config.modules.settings.shebang.enable {
    services.envfs.enable = true;
  };
}