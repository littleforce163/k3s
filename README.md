# k3s
## 0. env
```
ubuntu: 18.04
k3s: v1.18.4
x64 CPU
```

## 1. prepare
1.1 vim /etc/sysctl.conf
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

net.ipv4.conf.all.arp_ignore = 1
net.ipv4.conf.all.arp_announce = 0
net.ipv4.conf.all.rp_filter = 0
```
1.2 sysctl -p
>
1.3 install ipvs
```
sudo apt-get install -y ipvsadm ipset
```

## 2. server install
2.1 preprare files
```
cp k3s /usr/local/bin/k3s
chmod +x /usr/local/bin/k3s
sudo mkdir -p /var/lib/rancher/k3s/agent/images/
sudo cp k3s-airgap-images-amd64.tar /var/lib/rancher/k3s/agent/images/
docker load -i k3s-airgap-images-amd64.tar
```
2.2 vim install.sh
```
## at top add below env:
export INSTALL_K3S_SKIP_DOWNLOAD=true
export K3S_KUBECONFIG_MODE=644
export K3S_CLUSTER_SECRET=k3s
export INSTALL_K3S_EXEC="server \
--docker \
--no-deploy=traefik \
--flannel-backend=none \
--no-flannel \
--kube-apiserver-arg=service-node-port-range=10000-65500 \
--cluster-cidr=10.42.0.0/16 \
--kube-proxy-arg=proxy-mode=ipvs \
--kube-proxy-arg=masquerade-all=true \
--kube-proxy-arg=metrics-bind-address=0.0.0.0 \
"
```
2.3 install 
```
chmod +x install.sh
./install.sh
kubectl apply -f calico.yaml
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
# note token that to be used when install agent
sudo cat /var/lib/rancher/k3s/server/node-token
```
## 3. agent install
3.1 prepare files
```
cp k3s /usr/local/bin/k3s
chmod +x /usr/local/bin/k3s
sudo mkdir -p /var/lib/rancher/k3s/agent/images/
sudo cp k3s-airgap-images-amd64.tar /var/lib/rancher/k3s/agent/images/
docker load -i k3s-airgap-images-amd64.tar
```
3.2 vim k3s-install.sh
```
## set url to your server ip/dns
k3s_url="https://192.168.1.10:6443"
## set token to server command: sudo cat /var/lib/rancher/k3s/server/node-token
k3s_token="K10be9b9e7dc3751dde146cb6f586682be66b21d5d8490816745b8ba1794b54bd72::server:c5520f64db4aaa6c53fbbdd29fa2cb73"
```
3.3 install
```
chmod +x k3s-install.sh
./k3s-install.sh
```

## 4. rancher
```
docker run -d \
  -v /var/docker/rancher:/var/lib/rancher \
  -p 5080:80 \
  -p 5443:443 \
  rancher/rancher:stable
```
```
http://your_ip:5443
```
