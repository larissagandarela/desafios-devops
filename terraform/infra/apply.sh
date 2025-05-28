#!/bin/bash

SSH_CIDR=$1
REGION=$2

if [ -z "$SSH_CIDR" ] || [ -z "$REGION" ]; then
  echo "Uso: ./apply.sh <ssh_cidr> <region>"
  echo "Exemplo: ./apply.sh 203.0.113.0/24 us-east-1"
  exit 1
fi

terraform init
terraform plan -var "ssh_cidr=$SSH_CIDR" -var "region=$REGION"
terraform apply -auto-approve -var "ssh_cidr=$SSH_CIDR" -var "region=$REGION"

echo "==============================="
echo "Infraestrutura aplicada com sucesso!"
terraform output
echo "==============================="
