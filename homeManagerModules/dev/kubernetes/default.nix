{
  lib,
  config,
  pkgs,
  osConfig,
  ...
}:

{
  options.homeModules.dev.kubernetes = {
    enable = lib.mkEnableOption "Kubernetes Administration Tools";
    openshift.enable = lib.mkEnableOption "Openshift Administration Tools";
    minikube.enable = lib.mkEnableOption "Minikube for local testing";
    flux.enable = lib.mkEnableOption "Fluxcd Administration Tools";
  };

  config =
    let
      cfg = config.homeModules.dev.kubernetes;
      openshiftPackages = with pkgs; [
        ocm
        openshift
      ];
      minikubePackages = with pkgs; [ minikube ];
      fluxPackages = with pkgs; [
        fluxcd
      ];
      optionals = lib.lists.optionals;
      isDefaultShell = shellPkg: (osConfig.users.defaultUserShell == shellPkg);
    in
    lib.mkIf config.homeModules.dev.kubernetes.enable {
      home.packages =
        with pkgs;
        [
          kubernetes-helm
          kubectl
          kustomize
          kubectx
          kubefetch
          kompose
        ]
        ++ optionals (cfg.openshift.enable) openshiftPackages
        ++ optionals (cfg.minikube.enable) minikubePackages
        ++ optionals (cfg.flux.enable) fluxPackages;

      home.shellAliases = {
        k = "kubectl";
        kctx = "kubectx";
        kns = "kubens";
      };

      programs.kubecolor = {
        enable = true;
        enableAlias = true;
        enableZshIntegration = isDefaultShell pkgs.zsh;
        settings = {
          preset = "dark";
          theme = {
            base = {
              info = "fg=#cad3f5";
              primary = "fg=#c6a0f6";
              secondary = "fg=#91d7e3";
              success = "fg=#a6da95:bold";
              warning = "fg=#eed49f:bold";
              danger = "fg=#ed8796:bold";
              muted = "fg=#8087a2";
              key = "fg=#b7bdf8:bold";
            };
            default = "fg=#cad3f5";
            data = {
              key = "fg=#b7bdf8:bold";
              string = "fg=#cad3f5";
              true = "fg=#a6da95:bold";
              false = "fg=#ed8796:bold";
              number = "fg=#c6a0f6";
              null = "fg=#8087a2";
              quantity = "fg=#c6a0f6";
              duration = "fg=#f5a97f";
              durationfresh = "fg=#a6da95";
              ratio = {
                zero = "fg=#8087a2";
                equal = "fg=#a6da95";
                unequal = "fg=#eed49f";
              };
            };
            status = {
              success = "fg=#a6da95:bold";
              warning = "fg=#eed49f:bold";
              error = "fg=#ed8796:bold";
            };
            table = {
              header = "fg=#cad3f5:bold";
              columns = "fg=#cad3f5";
            };
            stderr = {
              default = "fg=#cad3f5";
              error = "fg=#ed8796:bold";
            };
            describe = {
              key = "fg=#b7bdf8:bold";
            };
            apply = {
              created = "fg=#a6da95";
              configured = "fg=#eed49f";
              unchanged = "fg=#cad3f5";
              dryrun = "fg=#91d7e3";
              fallback = "fg=#cad3f5";
            };
            explain = {
              key = "fg=#b7bdf8:bold";
              required = "fg=#24273a:bold";
            };
            options = {
              flag = "fg=#b7bdf8:bold";
            };
            version = {
              key = "fg=#b7bdf8:bold";
            };
          };
        };
      };

      homeModules.applications.vscode = {
        additionalUserSettings = {
          "yaml.schemas" = {
            "kubernetes" = [
              "secret.yaml"
              "pvc.yaml"
              "deployment.yaml"
              "certficate.yaml"
              "deployment.yaml"
              "job.yaml"
            ];
          };
          "vs-kubernetes" = {
            "vs-kubernetes.minikube-show-information-expiration" = "2100-01-01T19:42:00.282Z";
            "vs-kubernetes.crd-code-completion" = "disabled";
          };
        };

        additionalExtensions = with pkgs; [
          vscode-extensions.tim-koehler.helm-intellisense
          vscode-extensions.redhat.vscode-yaml # is needed for the k8s extension
          vscode-extensions.ms-kubernetes-tools.vscode-kubernetes-tools
        ];

        additionalSnippets.yaml = {
          "Create SOPS secret, do not forget to encrypt!" = {
            prefix = [ "k-sops-secret" ];
            description = "Create a k8s secret, ready to be decrypted with SOPS";
            body = [
              "apiVersion: v1"
              "kind: Secret"
              "type: Opaque"
              "metadata:"
              "\tname: $1"
              "\tnamespace: $2"
              "stringData:"
              "\t$3"
            ];
          };
          "Create PVC" = {
            prefix = [ "k-pvc" ];
            description = "Create a k8s persisten volume claim";
            body = [
              "apiVersion: v1"
              "kind: PersistentVolumeClaim"
              "metadata:"
              "\tname: $1"
              "\tnamespace: $2"
              "spec:"
              "\taccessModes:"
              "\t\t- $3"
              "\tstorageClassName: longhorn"
              "\tresources:"
              "\t\trequests:"
              "\t\t\tstorage: $4"
            ];
          };
          "Create service" = {
            prefix = [ "k-service" ];
            description = "";
            body = [
              "apiVersion: v1"
              "kind: Service"
              "metadata:"
              "\tname: $1"
              "\tnamespace: $2"
              "\tlabels:"
              "\t\tapp: $1"
              "spec:"
              "\tselector:"
              "\t\tapp: $1"
              "\tports:"
              "\t\t- protocol: \${3|TCP,UDP|}"
              "\t\t\tport: \${4|80|}"
              "\t\t\ttargetPort: $5"
              "\ttype: ClusterIP"
            ];
          };
          "Create deployment" = {
            prefix = [ "k-deployment" ];
            description = "Create a k8s deployment";
            body = [
              "apiVersion: apps/v1"
              "kind: Deployment"
              "metadata:"
              "\tname: $1"
              "\tnamespace: $2"
              "spec:"
              "\treplicas: 1"
              "\tselector:"
              "\t\tmatchLabels:"
              "\t\t\tapp: $1"
              "\ttemplate:"
              "\t\tmetadata:"
              "\t\t\tlabels:"
              "\t\t\t\tapp: $1"
              "\t\tspec:"
              "\t\t\tcontainers:"
              "\t\t\t\t- name: $1"
              "\t\t\t\t\timage: $3"
            ];
          };
          "Create image repository and policy" = {
            prefix = [ "k-image" ];
            description = "Create a Flux image repository and policy";
            body = [
              "apiVersion: image.toolkit.fluxcd.io/v1beta1"
              "kind: ImageRepository"
              "metadata:"
              "\tname: $1"
              "\tnamespace: flux-system"
              "spec:"
              "\timage: $1/$1"
              "\tinterval: 1h"
              "---"
              "apiVersion: image.toolkit.fluxcd.io/v1beta1"
              "kind: ImagePolicy"
              "metadata:"
              "\tname: $1"
              "\tnamespace: flux-system"
              "spec:"
              "\timageRepositoryRef:"
              "\t\tname: $1"
              "\tpolicy:"
              "\tsemver:"
              "\t\trange: \"0.x.x\""
            ];
          };
        };
      };
    };
}
