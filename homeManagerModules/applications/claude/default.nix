{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  claudeSkillPackages = lib.filterAttrs (
    name: _: lib.hasSuffix "-claude" name
  ) inputs.llm-skills.packages.${pkgs.system};
in
{
  options.homeModules.applications.claude = {
    enable = lib.mkEnableOption "Claude-Code";
  };

  config = lib.mkIf config.homeModules.applications.claude.enable {
    programs.claude-code = {
      enable = true;
      skills = lib.mapAttrs' (
        name: drv: lib.nameValuePair (lib.removeSuffix "-claude" name) drv
      ) claudeSkillPackages;
    };
  };
}
