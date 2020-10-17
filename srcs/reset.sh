#!bin/zsh
eval $(minikube docker-env)
kubectl delete -f ./srcs/k8s/mysql
kubectl delete -f ./srcs/k8s/nginx
kubectl delete -f ./srcs/k8s/wordpress
kubectl delete -f ./srcs/k8s/phpmyadmin
kubectl delete -f ./srcs/k8s/wordpress
kubectl delete -f ./srcs/k8s/grafana
kubectl delete -f ./srcs/k8s/InfluxDB
kubectl delete -f ./srcs/k8s/ftps
kubectl delete -f ./srcs/k8s/MetalLB
docker image rm -f nginx-test mysql-test wp-test pma-test gra-test inf-test ftps-test
export DOCKER_TLS_VERIFY=""
export DOCKER_HOST=""
export DOCKER_CERT_PATH=""
export MINIKUBE_ACTIVE_DOCKERD=""
minikube stop
