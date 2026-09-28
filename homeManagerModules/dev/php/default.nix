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
      (php85.withExtensions ({ enabled, all }: enabled ++ [ all.tidy ]))
      php85Packages.composer
      ant
    ];
  };
}
