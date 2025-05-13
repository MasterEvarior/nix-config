{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:

{
  options.homeModules.applications.yazi = {
    enable = lib.mkEnableOption "Yazi File Manager";
  };

  config =
    let
      isDefaultShell = shellPkg: (osConfig.users.defaultUserShell == shellPkg);
    in
    lib.mkIf config.homeModules.applications.yazi.enable {

      home.packages = with pkgs; [
        fzf
        zoxide
      ];

      programs.yazi = {
        enable = true;
        enableZshIntegration = isDefaultShell pkgs.zsh;
        enableBashIntegration = isDefaultShell pkgs.bash;
        enableFishIntegration = isDefaultShell pkgs.fish;
      };

      home.file.src = {
        recursive = true;
        source = ./assets;
        target = ".config/yazi/";
      };
    };
}
