# k3s

## don't download
INSTALL_K3S_SKIP_DOWNLOAD=true

## chmod /etc/rancher/k3s/k3s.yaml
export K3S_KUBECONFIG_MODE=644

## secret token
export K3S_CLUSTER_SECRET=k3s

## server, docker, without traefik, no flannel, reset port range
export INSTALL_K3S_EXEC="server --docker --no-deploy=traefik --no-flannel --kube-apiserver-arg=service-node-port-range=1-65500"

