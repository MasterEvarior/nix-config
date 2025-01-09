{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.php = {
    enable = lib.mkEnableOption "PHP";
  };

  config = lib.mkIf config.homeModules.dev.php.enable {
    home.packages = with pkgs; [
      (php84.withExtensions ({ enabled, all }: enabled ++ [ all.tidy ]))
      php84Packages.composer
      symfony-cli
      ant
    ];
  };
}
