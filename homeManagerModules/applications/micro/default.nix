{
  lib,
  config,
  ...
}:

{
  options.homeModules.applications.micro = {
    enable = lib.mkEnableOption "Micro";
    makeDefault = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Wether to set Micro as the default editor for everything shell";
    };
    replaceNano = lib.mkOption {
      default = true;
      example = true;
      type = lib.types.bool;
      description = ''
        If true, this will disable the nano HM module and set an alias to redirect "nano" to "micro"
      '';
    };
  };

  config =
    let
      cfg = config.homeModules.applications.micro;
      alias = if cfg.replaceNano then { nano = "micro"; } else { };
      variables =
        if cfg.makeDefault then
          {
            VISUAL = "micro";
            EDITOR = "micro";
          }
        else
          { };
      themeName = "catppuccin-mocha";
    in
    lib.mkIf config.homeModules.applications.micro.enable {
      programs.micro = {
        enable = true;
        settings = {
          colorscheme = themeName;
        };
      };

      home.file.".config/micro/colorschemes/${themeName}.micro".text = ''
        color-link default "#cdd6f4,#1e1e2e"
        color-link comment "#9399b2"

        color-link identifier "#89b4fa"
        color-link identifier.class "#89b4fa"
        color-link identifier.var "#89b4fa"

        color-link constant "#fab387"
        color-link constant.number "#fab387"
        color-link constant.string "#a6e3a1"

        color-link symbol "#f5c2e7"
        color-link symbol.brackets "#f2cdcd"
        color-link symbol.tag "#89b4fa"

        color-link type "#89b4fa"
        color-link type.keyword "#f9e2af"

        color-link special "#f5c2e7"
        color-link statement "#cba6f7"
        color-link preproc "#f5c2e7"

        color-link underlined "#89dceb"
        color-link error "bold #f38ba8"
        color-link todo "bold #f9e2af"

        color-link diff-added "#a6e3a1"
        color-link diff-modified "#f9e2af"
        color-link diff-deleted "#f38ba8"

        color-link gutter-error "#f38ba8"
        color-link gutter-warning "#f9e2af"

        color-link statusline "#cdd6f4,#181825"
        color-link tabbar "#cdd6f4,#181825"
        color-link indent-char "#45475a"
        color-link line-number "#45475a"
        color-link current-line-number "#b4befe"

        color-link cursor-line "#313244,#cdd6f4"
        color-link color-column "#313244"
        color-link type.extended "default"
      '';

      home.file.".config/micro/bindings.json".text = (
        builtins.toJSON {
          "Ctrl-y" = "CutLine";
          "Ctrl-x" = "Quit";
        }
      );

      home.shellAliases = alias;
      home.sessionVariables = variables;
      homeModules.applications.nano.enable = (!cfg.replaceNano);
    };
}
