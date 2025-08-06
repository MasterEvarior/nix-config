{
  lib,
  config,
  ...
}:

{
  options.homeModules.applications.lazygit = {
    enable = lib.mkEnableOption "Lazygit";
  };

  config = lib.mkIf config.homeModules.applications.lazygit.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        theme = {
          activeBorderColor = [
            "#f4dbd6"
            "bold"
          ];
          inactiveBorderColor = [
            "#a5adcb"
          ];
          optionsTextColor = [
            "#8aadf4"
          ];
          selectedLineBgColor = [
            "#363a4f"
          ];
          cherryPickedCommitBgColor = [
            "#494d64"
          ];
          cherryPickedCommitFgColor = [
            "#f4dbd6"
          ];
          unstagedChangesColor = [
            "#ed8796"
          ];
          defaultFgColor = [
            "#cad3f5"
          ];
          searchingActiveBorderColor = [
            "#eed49f"
          ];
        };
        authorColors = {
          "*" = "#b7bdf8";
        };
      };
    };
  };
}
