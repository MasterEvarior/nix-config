{
  lib,
  config,
  ...
}:

{
  options.homeModules.applications.claude = {
    enable = lib.mkEnableOption "Claude-Code";
  };

  config = lib.mkIf config.homeModules.applications.claude.enable {
    programs.claude-code = {
      enable = true;
    };
  };
}
