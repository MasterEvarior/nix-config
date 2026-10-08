{
  lib,
  pkgs,
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
        "fence/fence.json".text = builtins.toJSON {
          "$schema" =
            "https://raw.githubusercontent.com/fencesandbox/v${cfg.fence.package.version}/main/docs/schema/fence.schema.json";
          extends = "code-relaxed";
          filesystem = {
            # NixOS executables and their shared libs/dynamic linker live under
            # /nix/store, which isn't covered by fence's hardcoded FHS default
            # paths (/usr, /bin, /lib, ...), so exec fails with EACCES without this.
            # https://github.com/fencesandbox/fence/issues/232
            allowRead = [ "/nix/store" ];
            allowExecute = [ "/nix/store" ];
          };
          command = {
            deny = [
              # git
              "git ps"
              "git yeet"

              # nix
              "nuc"
              "ncg"
              "nix-collect-garbage"
              "nrs"
              "nixos-rebuild --flake . switch"
              "nixos-rebuild switch"
            ];
            allow = [
              "gh issue create"
            ];
            acceptSharedBinaryCannotRuntimeDeny = [
              "chroot"
            ];
          };

          network.allowLocalOutbound = false;
        };
      };

      programs.claude-code = {
        enable = true;
        inherit skills;

        context = ''
          Environment & System Rules:
          - This system runs NixOS (declarative Linux distribution without standard FHS binary paths).
          - Do NOT run FHS package manager commands (e.g., `apt`, `pacman`, `yum`, `dnf`).
          - Do NOT execute raw binary installer scripts that expect standard dynamic linkers in `/lib64` or `/usr/lib`.
          - If a repository has a flake.nix, prefer to use nix develop instead of trying to install tools
          - To temporarily run missing CLI tools, suggest using `nix-shell -p <package>` or `nix run nixpkgs#<package>`.
          - For permanent tool additions, remember that there is a config file that needs editing. You are NOT allowed to do so without prior authorization!
        '';
      };
    };
}
