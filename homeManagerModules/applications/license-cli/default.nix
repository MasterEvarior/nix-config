{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.license-cli = {
    enable = lib.mkEnableOption "cli to generate licenses";
  };

  config = lib.mkIf config.homeModules.applications.license-cli.enable {
    home.packages = with pkgs; [
      license-go
    ];

    programs.git.aliases = {
      license = "!f() { license \"$@\"; }; f";
    };
  };
}
