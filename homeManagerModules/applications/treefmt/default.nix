{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.applications.treefmt = {
    enable = lib.mkEnableOption "Treefmt";
    additionalFormatters = lib.mkOption {
      type =
        with lib.types;
        listOf (submodule {
          options = {
            name = lib.mkOption {
              example = "mdformat";
              type = str;
              description = "Name of the formatter";
            };
            command = lib.mkOption {
              example = "mdformat";
              type = str;
              description = "Command used to format";
            };
            includes = lib.mkOption {
              example = [ "*.md" ];
              type = listOf str;
              description = "List of files that should be formatted";
            };
            excludes = lib.mkOption {
              default = [ ];
              example = [ ];
              type = listOf str;
              description = "List of files that should NOT be formatted";
            };
            options = lib.mkOption {
              default = [ ];
              example = [ ];
              type = listOf str;
              description = "List of options that should be passed to the command";
            };
            package = lib.mkOption {
              example = pkgs.mdformat;
              type = package;
              description = "";
            };
          };
        });
      example = [
        {
          name = "mdformat";
          command = "mdformat";
          includes = [ "*.md" ];
          options = [ ];
          package = pkgs.mdformat;
        }
      ];
      default = [ ];
      description = "A list of additional formatters to be installed and configured";
    };
  };

  config =
    let
      cfg = config.homeModules.applications.treefmt;
      generateFormatterTOML = formatter: ''
        [formatter.${formatter.name}]
        command = "${formatter.command}"
        options = ${builtins.toJSON formatter.options}
        excludes = ${builtins.toJSON formatter.excludes}
        includes = ${builtins.toJSON formatter.includes}
      '';
      generateEntireTOML = builtins.concatStringsSep "\n" (
        lib.map generateFormatterTOML cfg.additionalFormatters
      );
      packages = map (p: p.package) cfg.additionalFormatters;
    in
    lib.mkIf config.homeModules.applications.treefmt.enable {
      homeModules.applications.treefmt.additionalFormatters = lib.mkBefore [
        {
          name = "mdformat";
          command = "mdformat";
          includes = [ "*.md" ];
          package = pkgs.mdformat;
        }
        {
          name = "yamlfmt";
          command = "yamlfmt";
          includes = [
            "*.yml"
            "*.yaml"
          ];
          package = pkgs.yamlfmt;
        }
        {
          name = "jsonfmt";
          command = "jsonfmt";
          includes = [
            "*.json"
            "*.jsonc"
          ];
          options = [ "-w" ];
          package = pkgs.jsonfmt;
        }
        {
          name = "beautysh";
          command = "beautysh";
          includes = [ "*.sh" ];
          options = [
            "-i"
            "2"
          ];
          package = pkgs.beautysh;
        }
      ];

      home.packages =
        with pkgs;
        [
          treefmt
        ]
        ++ packages;

      home.shellAliases = {
        treefmt-init = ''echo '${generateEntireTOML}' > ./treefmt.toml'';
        treefmt-global = "treefmt --tree-root . --config-file ~/.config/treefmt/global.toml";
      };

      home.file.".config/treefmt/global.toml".text = generateEntireTOML;
    };
}
