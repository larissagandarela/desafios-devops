#!/bin/bash

set -e

echo "Iniciando deploy da aplicação no Kubernetes..."

if ! minikube status >/dev/null 2>&1; then
  echo "Iniciando Minikube..."
  minikube start
fi

if ! minikube addons list | grep -q "^ingress.*enabled"; then
  echo "Ativando ingress no Minikube..."
  minikube addons enable ingress
fi

echo "Construindo a imagem Docker..."
eval $(minikube docker-env)
docker build -t app-idwall:latest .

MINIKUBE_IP=$(minikube ip)
DOMAIN="app.${MINIKUBE_IP}.nip.io"

echo "Aplicando namespace..."
kubectl apply -f k8s/namespace.yaml

echo "Aguardando namespace estar disponível..."
timeout=30
while ! kubectl get namespace idwall-app >/dev/null 2>&1; do
  sleep 1
  timeout=$((timeout-1))
  if [ $timeout -le 0 ]; then
    echo "Timeout esperando namespace ser criado"
    exit 1
  fi
done

echo "Aplicando manifestos Kubernetes..."

kubectl apply -f k8s/configmap.yaml
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml

echo "Gerando ingress com domínio ${DOMAIN}..."
sed "s/__DOMAIN__/${DOMAIN}/g" k8s/ingress.yaml > k8s/ingress-temp.yaml

kubectl apply -f k8s/ingress-temp.yaml
rm k8s/ingress-temp.yaml

echo "Aguardando rollout do deployment..."
kubectl rollout status deployment/app-idwall -n idwall-app

echo "Pods rodando no namespace idwall-app:"
kubectl get pods -n idwall-app

echo "----------------------------------------------------"
echo "Aplicação implantada com sucesso!"
echo "Acesse em: http://$DOMAIN"
echo "----------------------------------------------------"