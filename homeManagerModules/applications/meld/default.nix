{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.meld = {
    enable = lib.mkEnableOption "Meld";
    setAsDiffTool = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = "Set as global diff tool";
    };
  };

  # Maybe later?
  # https://wiki.gnome.org/Apps/Meld/DarkThemes
  config =
    let
      cfg = config.homeModules.applications.meld;
    in
    lib.mkIf config.homeModules.applications.meld.enable {
      home.packages = with pkgs; [
        meld
      ];

      programs.git.settings = {
        alias = {
          diffm = "difftool --tool=meld";
          diffmd = "difftool --dir-diff --tool=meld";
        };
        diff = lib.mkIf cfg.setAsDiffTool {
          tool = "meld";
        };
      };

    };
}
