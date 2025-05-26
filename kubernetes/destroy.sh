#!/bin/bash

echo "Parando túnel do Minikube (se estiver rodando)..."

(pkill -f "minikube tunnel" 2>/dev/null || \
powershell.exe -Command "Stop-Process -Name minikube -Force" 2>/dev/null || \
echo "Túnel não estava rodando")

echo "Deletando cluster Minikube..."
minikube delete
