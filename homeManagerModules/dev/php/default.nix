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

  config = lib.mkIf config.homeModules.dev.php.enable (
    let
      php = pkgs.php85.withExtensions ({ enabled, all }: enabled ++ [ all.tidy ]);
    in
    {
      home.packages = [
        php
        php.packages.composer
        pkgs.ant
      ];
    }
  );
}
