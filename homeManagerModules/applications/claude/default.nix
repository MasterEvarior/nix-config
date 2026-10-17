{
  lib,
  pkgs,
  pkgs-unstable,
  config,
  inputs,
  ...
}:
{
  options.homeModules.applications.claude = {
    enable = lib.mkEnableOption "Claude-Code";
    fence = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Whether to sandbox Claude Code using fence.";
      };

      package = lib.mkPackageOption pkgs "fence" {
        default = [ "fence" ];
        extraDescription = "The fence package to use for sandboxing.";
      };
    };
  };

  config =
    let
      cfg = config.homeModules.applications.claude;
      skillPackages = lib.filterAttrs (
        name: _: lib.hasSuffix "-claude" name
      ) inputs.llm-skills.packages.${pkgs.system};
      skills = lib.mapAttrs' (
        name: drv: lib.nameValuePair (lib.removeSuffix "-claude" name) drv
      ) skillPackages;
    in
    lib.mkIf config.homeModules.applications.claude.enable {
      home.packages = [
        cfg.fence.package
      ];

      home.shellAliases = lib.mkIf cfg.fence.enable {
        claude = "${lib.getExe cfg.fence.package} -- claude";
      };

      xdg.configFile = lib.mkIf cfg.fence.enable {
        "fence/fence.json".text = builtins.toJSON (import ./fence-config.nix { inherit cfg; });
      };

      programs.claude-code = {
        enable = true;
        inherit skills;

        mcpServers = {
          context7 = {
            type = "stdio";
            command = lib.getExe pkgs-unstable.context7-mcp;
          };
          nixos = {
            type = "stdio";
            command = lib.getExe pkgs-unstable.mcp-nixos;
            env = {
              FASTMCP_CHECK_FOR_UPDATES = "off";
            };
          };
        };

        context = ''
          Environment & System Rules:
          - This system runs NixOS (declarative Linux distribution without standard FHS binary paths).
          - Do NOT run FHS package manager commands (e.g. `apt`, `pacman`, `yum`, `dnf`).
          - Do NOT execute raw binary installer scripts that expect standard dynamic linkers in `/lib64` or `/usr/lib`.
          - If a repository has a flake.nix, prefer to use nix develop instead of trying to install tools
          - To temporarily run missing CLI tools, suggest using `nix-shell -p <package>` or `nix run nixpkgs#<package>`.
          - For permanent tool additions, remember that there is a config file that needs editing. You are NOT allowed to do so without prior authorization!

        ''
        + lib.optionalString cfg.fence.enable "You are running in a sandbox and might not be able to access certain website, run certain commands and so on. Do not try to cirumvent this, instead alert the user about this if necessary.";
      };
    };
}
