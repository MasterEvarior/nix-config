{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:

{
  options.homeModules.desktop.sway.swaylock =
    let
      # Extract the serial from something like this: "LG Electronics LG ULTRAWIDE 0x00059AB6" to this: 0x00059AB6
      extractSerial = output: lib.lists.last (lib.strings.splitString " " output);
      # Get the correct output name from the JSON, something like DP-3
      extractOutputName =
        output:
        "$(swaymsg -t get_outputs | jq -r '.[] | select(.type == \"output\") | select( .serial | endswith(\"${(extractSerial output)}\")) | .name')";
      # Extract the image path from something like "./my/image.png fill"
      extractImagePath = bgValue: builtins.elemAt (lib.strings.splitString " " bgValue) 0;
      extractBackgrounds =
        outputs:
        lib.strings.concatStrings (
          lib.attrsets.mapAttrsToList (
            name: value: " --image \"${(extractOutputName name)}\":${extractImagePath (value.bg)}"
          ) outputs
        );
    in
    {
      enable = lib.mkEnableOption "Swaylock";
      theme = lib.mkOption {
        example = {
          subtext0 = "#a5adcb";
          overlay2 = "#939ab7";
        };
        type = lib.types.attrs;
        description = "Theme";
      };
      backgroundImages = lib.mkOption {
        default = (extractBackgrounds osConfig.modules.desktop.sway.outputs);
        example = "./my/image.png";
        type = lib.types.str;
        description = "";
      };
    };

  config =
    let
      cfg = config.homeModules.desktop.sway.swaylock;
      stripHashtag = lib.strings.stringAsChars (x: if x == "#" then "" else x);
      lockCommand = "${pkgs.swaylock}/bin/swaylock --show-keyboard-layout --indicator-idle-visible --indicator-caps-lock ${cfg.backgroundImages}";
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
