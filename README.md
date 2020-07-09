# k3s

## sysctl
vim /etc/sysctl.conf
```
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1

#开启反向路径过滤
#net.ipv4.conf.all.rp_filter = 1
#net.ipv4.conf.default.rp_filter = 1

vm.swappiness = 0
fs.file-max = 6815744
kernel.sysrq = 1
kernel.pid_max = 600000
net.ipv4.ip_local_port_range = 2048 65000

net.core.somaxconn = 262144 
net.core.rmem_default = 2621440
net.core.wmem_default = 2621440
net.core.rmem_max = 2621440
net.core.wmem_max = 2621440
net.ipv4.tcp_rmem = 4096 655360 2621440
net.ipv4.tcp_wmem = 4096 655360 2621440
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_keepalive_time = 30
```

## don't download
INSTALL_K3S_SKIP_DOWNLOAD=true

## chmod /etc/rancher/k3s/k3s.yaml
export K3S_KUBECONFIG_MODE=644

## secret token
export K3S_CLUSTER_SECRET=k3s

## server, docker, without traefik, no flannel, reset port range
export INSTALL_K3S_EXEC="server --docker --no-deploy=traefik --no-flannel --kube-apiserver-arg=service-node-port-range=1-65500"

