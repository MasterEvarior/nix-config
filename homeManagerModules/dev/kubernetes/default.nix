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

      homeModules.applications.vscode = {
        additionalUserSettings = {
          "yaml.schemas" = {
            "kubernetes" = "*.yaml";
          };
        };

        additionalExtensions = with pkgs; [
          vscode-extensions.tim-koehler.helm-intellisense
          vscode-extensions.redhat.vscode-yaml # is needed for the k8s extension
          vscode-extensions.ms-kubernetes-tools.vscode-kubernetes-tools
        ];
      };
    };
}
