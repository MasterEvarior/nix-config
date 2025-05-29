{
  lib,
  config,
  inputs,
  ...
}:

{
  options.homeModules.applications.openconnect = {
    enable = lib.mkEnableOption "Open Connect VPN Client";
  };

  config = lib.mkIf config.homeModules.applications.openconnect.enable {
    home.packages = [
      # https://github.com/vlaci/openconnect-sso/pull/152
      inputs.openconnect-sso.packages.x86_64-linux.default
    ];
  };
}
