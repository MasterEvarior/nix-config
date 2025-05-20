{
  lib,
  config,
  osConfig,
  pkgs,
  ...
}:

{
  imports = [
    ./fuzzel.nix
    ./mako.nix
    ./snipping-tools.nix
    ./sway.nix
    ./swaylock.nix
    ./waybar.nix
    ./wlogout.nix
  ];

  options.homeModules.desktop.sway.module = {
    enable = lib.mkEnableOption "Sway Module";
    themeCustomization = lib.mkOption {
      default = { };
      example = {
        subtext1 = "#b8c0e0";
        subtext0 = "#a5adcb";
      };
      type = lib.types.attrs;
      description = "Override default theme values";
    };
  };

  config =
    let
      defaultTheme = {
        rosewater = "#f4dbd6";
        flamingo = "#f0c6c6";
        pink = "#f5bde6";
        mauve = "#c6a0f6";
        red = "#ed8796";
        maroon = "#ee99a0";
        peach = "#f5a97f";
        yellow = "#eed49f";
        green = "#a6da95";
        teal = "#8bd5ca";
        sky = "#91d7e3";
        sapphire = "#7dc4e4";
        blue = "#8aadf4";
        lavender = "#b7bdf8";
        text = "#cad3f5";
        subtext1 = "#b8c0e0";
        subtext0 = "#a5adcb";
        overlay2 = "#939ab7";
        overlay1 = "#8087a2";
        overlay0 = "#6e738d";
        surface2 = "#5b6078";
        surface1 = "#494d64";
        surface0 = "#363a4f";
        base = "#24273a";
        mantle = "#1e2030";
        crust = "#181926";
      };
      cfg = config.homeModules.desktop.sway.module;
      mergedTheme = lib.mkMerge [
        defaultTheme
        cfg.themeCustomization
      ];
      enableByDefault = lib.mkDefault osConfig.modules.desktop.sway.enable;
    in
    lib.mkIf config.homeModules.desktop.sway.module.enable {

      homeModules.applications = {
        bemoji.enable = enableByDefault;
        zathura = {
          enable = enableByDefault;
          makeDefaultApplication = true;
        };
        yazi.enable = true;
      };

      homeModules.desktop.sway = {
        enable = enableByDefault;
        theme = mergedTheme;
        terminal = "${pkgs.alacritty}/bin/alacritty";
        fileBrowser = "${pkgs.alacritty}/bin/alacritty -e ${pkgs.yazi}/bin/yazi";
        bar = (lib.mkDefault null);
        fuzzel = {
          enable = enableByDefault;
          theme = mergedTheme;
        };
        mako = {
          enable = enableByDefault;
          theme = mergedTheme;
        };
        wlogout = {
          enable = enableByDefault;
          # Because wlogout uses CSS's rgba and rgb, there needs to be some manual adjustment to the theme still
          theme = mergedTheme;
        };
        waybar = {
          enable = enableByDefault;
          theme = mergedTheme;
        };
        swaylock = {
          enable = enableByDefault;
          theme = mergedTheme;
        };
        # TODO: fix this module
        snipping-tools.enable = enableByDefault;
      };
    };
}
