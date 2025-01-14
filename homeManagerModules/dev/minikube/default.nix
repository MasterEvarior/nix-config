{
  lib,
  config,
  pkgs,
  ...
}:

{
  options.homeModules.dev.minikube = {
    enable = lib.mkEnableOption "Minikube for learning/playing with Kubernetes";
  };

  config = lib.mkIf config.homeModules.dev.minikube.enable {
    home.packages = with pkgs; [
      kubectl
      minikube
    ];
  };
}
