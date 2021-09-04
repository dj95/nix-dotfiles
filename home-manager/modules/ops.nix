{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs; [
    ansible
    azure-cli
    docker-compose
    fluxcd
    kubectl
    kubectx
    kubernetes-helm
    kustomize
    terraform
  ];
}
