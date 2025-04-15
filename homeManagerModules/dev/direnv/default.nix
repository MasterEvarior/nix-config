{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:

{
  options.homeModules.dev.direnv = {
    enable = lib.mkEnableOption "Direnv";
  };

  config =
    let
      isDefaultShell = shellPkg: (osConfig.users.defaultUserShell == shellPkg);
    in
    lib.mkIf config.homeModules.dev.direnv.enable {
      programs.direnv = {
        enable = true;
        enableZshIntegration = isDefaultShell pkgs.zsh;
        enableBashIntegration = isDefaultShell pkgs.bash;
        enableFishIntegration = isDefaultShell pkgs.fish;
        nix-direnv.enable = true;
      };
    };
}
