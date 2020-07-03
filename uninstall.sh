sudo bash /usr/local/bin/k3s-killall.sh
docker stop `docker ps |awk {'print $1'}|grep -v CONTAINER`
docker rm -f $(docker ps -qa)
docker volume rm $(docker volume ls -q)
sudo bash /usr/local/bin/k3s-uninstall.sh
sudo modprobe -r ipip
