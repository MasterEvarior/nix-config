{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:

{
  options.homeModules.applications.zoxide = {
    enable = lib.mkEnableOption "Zoxide";
  };

  config =
    let
      isDefaultShell = shellPkg: (osConfig.users.defaultUserShell == shellPkg);
    in
    lib.mkIf config.homeModules.applications.zoxide.enable {
      programs.zoxide = {
        enable = true;
        enableBashIntegration = isDefaultShell pkgs.bash;
        enableFishIntegration = isDefaultShell pkgs.fish;
        enableNushellIntegration = isDefaultShell pkgs.nushell;
        enableZshIntegration = isDefaultShell pkgs.zsh;
        options = [
          "--cmd cd"
        ];
      };

      # needed for interactive mode
      home.packages = with pkgs; [
        fzf
      ];
    };
}
