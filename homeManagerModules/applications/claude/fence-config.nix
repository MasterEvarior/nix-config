{ cfg }: {
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

      # kubectl/oc: direct deletion
      "kubectl delete"
      "oc delete"
      "kubectl replace --force"
      "oc replace --force"

      # kubectl/oc: scaling / disruption
      "kubectl scale"
      "oc scale"
      "kubectl drain"
      "oc adm drain"
      "kubectl rollout restart"
      "oc rollout restart"
      "kubectl rollout undo"
      "oc rollout undo"

      # kubectl/oc: prune-based deletion
      "kubectl apply --prune"
      "oc apply --prune"

      # kubectl/oc: in-place mutation
      "kubectl patch"
      "oc patch"
      "kubectl edit"
      "oc edit"
      "kubectl set"
      "oc set"
      "kubectl annotate"
      "kubectl label"

      # kubectl/oc: namespace/project wide
      "kubectl delete namespace"
      "oc delete project"
      "oc adm prune"

      # kubectl/oc: RBAC / privilege-affecting
      "kubectl delete clusterrolebinding"
      "kubectl delete rolebinding"
      "kubectl create clusterrolebinding"
      "oc adm policy add-cluster-role-to-user"
      "oc adm policy add-scc-to-user"

      # kubectl/oc: secrets
      "kubectl delete secret"
      "kubectl create secret"

      # kubectl/oc: arbitrary exec / file overwrite in running pods
      "kubectl exec"
      "oc exec"
      "kubectl cp"
      "oc cp"
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
}
