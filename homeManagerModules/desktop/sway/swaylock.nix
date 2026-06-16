{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.desktop.sway.swaylock = {
    enable = lib.mkEnableOption "Swaylock";
    theme = lib.mkOption {
      example = {
        subtext0 = "#a5adcb";
        overlay2 = "#939ab7";
      };
      type = lib.types.attrs;
      description = "Theme";
    };
  };

  config =
    let
      cfg = config.homeModules.desktop.sway.swaylock;
      stripHashtag = lib.strings.stringAsChars (x: if x == "#" then "" else x);
      lockCommand = "${lib.getExe pkgs.swaylock} --show-keyboard-layout --indicator-idle-visible --indicator-caps-lock --ignore-empty-password";
    in
    lib.mkIf config.homeModules.desktop.sway.swaylock.enable {
      home.packages = with pkgs; [
        jq
      ];

      programs.swaylock = {
        enable = true;
        settings = {
          color = (stripHashtag cfg.theme.base);
          bs-hl-color = (stripHashtag cfg.theme.rosewater);
          caps-lock-bs-hl-color = (stripHashtag cfg.theme.rosewater);
          caps-lock-key-hl-color = (stripHashtag cfg.theme.green);
          inside-color = "00000000";
          inside-clear-color = "00000000";
          inside-caps-lock-color = "00000000";
          inside-ver-color = "00000000";
          inside-wrong-color = "00000000";
          key-hl-color = (stripHashtag cfg.theme.text);
          layout-bg-color = "00000000";
          layout-border-color = "00000000";
          layout-text-color = (stripHashtag cfg.theme.text);
          line-color = "00000000";
          line-clear-color = "00000000";
          line-caps-lock-color = "00000000";
          line-ver-color = "00000000";
          line-wrong-color = "00000000";
          ring-color = (stripHashtag cfg.theme.lavender);
          ring-clear-color = (stripHashtag cfg.theme.rosewater);
          ring-caps-lock-color = (stripHashtag cfg.theme.peach);
          ring-ver-color = (stripHashtag cfg.theme.blue);
          ring-wrong-color = (stripHashtag cfg.theme.maroon);
          separator-color = "00000000";
          text-color = (stripHashtag cfg.theme.text);
          text-clear-color = (stripHashtag cfg.theme.rosewater);
          text-caps-lock-color = (stripHashtag cfg.theme.peach);
          text-ver-color = (stripHashtag cfg.theme.blue);
          text-wrong-color = (stripHashtag cfg.theme.maroon);
        };
      };

      homeModules.desktop.sway.additionalKeybindings = {
        "+l" = "exec ${lockCommand}";
      };

      homeModules.desktop.sway.swayidle = {
        lock.command = lockCommand + "-f";
      };
    };
}
