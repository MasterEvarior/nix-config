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
          extends = "code";
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
              "git pfush"
              "git psfwl"
              "git psf"
              "git ps"
              "git yeet"
              "git rb"

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

          network = {
            allowedDomains = [ "*" ];
            deniedDomains = [
              # Error reporting
              "*.sentry.io"
              "*.ingest.sentry.io"
              "sentry.io"

              # Product analytics
              "*.posthog.com"
              "app.posthog.com"
              "us.posthog.com"
              "eu.posthog.com"

              # Feature flags / experimentation
              "*.statsig.com"
              "statsig.com"
              "statsig.anthropic.com"

              # Customer data platforms
              "*.segment.io"
              "*.segment.com"
              "api.segment.io"
              "cdn.segment.com"

              # Analytics
              "*.amplitude.com"
              "api.amplitude.com"
              "api2.amplitude.com"
              "*.mixpanel.com"
              "api.mixpanel.com"

              "*.heap.io"
              "*.heapanalytics.com"

              # Session recording
              "*.fullstory.com"
              "*.hotjar.com"
              "*.hotjar.io"
              "*.logrocket.io"
              "*.logrocket.com"

              # Error tracking
              "*.bugsnag.com"
              "notify.bugsnag.com"
              "*.rollbar.com"
              "api.rollbar.com"

              # APM / Monitoring
              "*.datadog.com"
              "*.datadoghq.com"

              "*.newrelic.com"
              "*.nr-data.net"

              # Feature flags
              "*.launchdarkly.com"
              "*.split.io"

              # Product analytics / user engagement
              "*.pendo.io"
              "*.intercom.io"
              "*.intercom.com"

              # Mobile attribution
              "*.appsflyer.com"
              "*.adjust.com"
              "*.branch.io"

              # Crash reporting
              "crashlytics.com"
              "*.crashlytics.com"
              "firebase-settings.crashlytics.com"
            ];
            allowLocalOutbound = false;
          };
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

        ''
        + lib.optionalString cfg.fence.enable "You are running in a sandbox and might not be able to access certain website, run certain commands and so on. Do not try to cirumvent this, instead alert the user about this if necessary.";
      };
    };
}
