{
  lib,
  config,
  ...
}:

{
  options.homeModules.applications.helix = {
    enable = lib.mkEnableOption "A post-modern text editor.";
  };

  config = lib.mkIf config.homeModules.applications.helix.enable {
    programs.helix = {
      enable = true;
    };
  };
}
