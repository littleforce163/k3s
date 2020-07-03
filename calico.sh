wget https://docs.projectcalico.org/manifests/calico.yaml
sed -i -e "s?192.168.0.0/16?10.42.0.0/16?g" calico.yaml

kubectl apply -f calico.yaml 
watch kubectl get pods --all-namespaces
