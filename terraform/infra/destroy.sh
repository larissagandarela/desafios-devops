#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Uso: $0 <ssh_cidr> <region>"
  echo "Exemplo: $0 203.0.113.0/24 us-east-1"
  exit 1
fi

SSH_CIDR=$1
REGION=$2

echo "Destruindo infraestrutura..."
terraform destroy -auto-approve -var "ssh_cidr=$SSH_CIDR" -var "region=$REGION"

echo "Recursos destruídos!"
