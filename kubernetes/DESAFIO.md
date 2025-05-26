# Desafio 02: Kubernetes

## Preparação de ambiente 

As ferramentas necessárias para que o repositório seja executado com sucesso e o deploy seja realizado no Kubernetes local são:

- Docker
- Kubectl
- Minikube
- Terminal Bash

## O que foi construido

O objetivo desta solução é demonstrar como executar o deploy de uma aplicação containerizada em um cluster Kubernetes local, utilizando Minikube.

## Passo a passo 

1. Criação da imagem Docker 

Para a criação da imagem Docker, foi utilizado o Dockerfile disponível no repositório. Como o ambiente de execução é um cluster Kubernetes local com Minikube, a imagem foi construída diretamente dentro do ambiente Docker do Minikube, evitando assim a necessidade de envio para um registro externo (como Docker Hub).

Foi necessária a alteração da versão do Alpine Linux de 9 para 18, uma vez que a versão anterior não permitia a geração correta da imagem. Isso possivelmente ocorreu devido a incompatibilidades com versões mais recentes de bibliotecas ou dependências utilizadas na aplicação.

O processo é feito com os seguintes comandos:

```bash
eval $(minikube docker-env)
docker build -t app-idwall:latest .
```

2. Criação dos manifestos Kubernetes

Com a imagem devidamente construída dentro do Minikube, foram criados e aplicados os manifestos Kubernetes, responsáveis por definir os recursos necessários para executar a aplicação no cluster.

Foram utilizados os seguintes manifestos:

- namespace
- configmap
- deployment
- service
- ingress

A aplicação dos manifestos é feita com os comandos: 

```bash
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/configmap.yaml   
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```
Observação: antes da aplicação, o script acessa o diretório /k8s onde estão localizados os arquivos YAML.

3. Criação do script deploy

Foi desenvolvido um script Bash que automatiza todo o processo de deploy da aplicação no cluster Kubernetes local utilizando Minikube.

O script executa as seguintes etapas:

- Verifica e inicia o Minikube, caso não esteja ativo;
- Ativa o addon de ingress;
- Inicia o túnel do Minikube para o serviço;
- Constrói a imagem Docker diretamente no ambiente do Minikube;
- Aplica os manifestos Kubernetes (namespace, configmap, deployment, service e ingress);
- Aguarda o rollout do deployment, garantindo que a aplicação esteja devidamente implantada e executando corretamente.

4. Verificação dos pods funcionando

Ao final do processo de deploy, é realizada a verificação dos pods para garantir que estão executando corretamente no cluster Kubernetes.

O script inclui o seguinte comando:

```bash
kubectl get pods -n idwall-app
```
Esse comando lista todos os pods no namespace idwall-app, permitindo acompanhar o status e confirmar que os pods estão na condição Running e prontos para atender às requisições.

5. URL de saída

Após a conclusão do deploy, o script exibe automaticamente a URL pública de acesso à aplicação, utilizando o domínio dinâmico do serviço nip.io, que resolve automaticamente o IP do Minikube sem a necessidade de configurações adicionais de DNS.

Exemplo de URL exibida:

```bash
http://app.127.0.0.1.nip.io

```

### Como aplicar 

Para executar a aplicação, basta rodar o script de deploy em um terminal com privilégios administrativos (sudo ou como root), garantindo assim que todas as etapas sejam executadas automaticamente.

Importante: certifique-se de estar no diretório raiz do projeto, onde está localizado o arquivo deploy.sh.

Comando para execução:

```bash
chmod +x deploy.sh && ./deploy.sh
```

### Como destruir

Se desejar encerrar completamente o ambiente, incluindo o cluster local, execute:

```bash
chmod +x deploy.sh && ./destroy.sh
```
Importante: certifique-se de estar no diretório raiz do projeto, onde está localizado o arquivo destroy.sh.

