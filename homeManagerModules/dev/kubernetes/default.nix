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
      openshiftPackages = with pkgs; [ ocm ];
      minikubePackages = with pkgs; [ minikube ];
      fluxPackages = with pkgs; [ fluxctl ];
      optionals = lib.lists.optionals;
    in
    lib.mkIf config.homeModules.dev.kubernetes.enable {
      home.packages =
        with pkgs;
        [
          kubernetes-helm
          kubectl
          kubeseal
          kustomize
        ]
        ++ optionals (cfg.openshift.enable) openshiftPackages
        ++ optionals (cfg.minikube.enable) minikubePackages
        ++ optionals (cfg.flux.enable) fluxPackages;

      homeModules.applications.vscode.additionalExtensions = with pkgs; [
        vscode-extensions.tim-koehler.helm-intellisense
      ];
    };
}
