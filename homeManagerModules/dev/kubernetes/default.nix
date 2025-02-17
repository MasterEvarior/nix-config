{
  lib,
  config,
  pkgs,
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
    in
    lib.mkIf config.homeModules.dev.kubernetes.enable {
      home.packages =
        with pkgs;
        [
          kubernetes-helm
          kubectl
          kustomize
          kubectx
        ]
        ++ optionals (cfg.openshift.enable) openshiftPackages
        ++ optionals (cfg.minikube.enable) minikubePackages
        ++ optionals (cfg.flux.enable) fluxPackages;

      home.shellAliases = {
        k = "kubectl";
        kctx = "kubectx";
        kns = "kubens";
      };

      homeModules.applications.vscode = {
        additionalUserSettings = {
          "yaml.schemas" = {
            "kubernetes" = "*.yaml";
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
              "\t\t\tspec:"
              "\t\t\t\tcontainers:"
              "\t\t\t\t\t- name: $1"
              "\t\t\t\t\t\timage: $3"
            ];
          };
        };
      };
    };
}
