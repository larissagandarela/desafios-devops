# Desafio 02: Kubernetes

## Preparação de ambiente 

As ferramentas necessárias para que o repositório seja executado com sucesso e o deploy seja realizado no Kubernetes local são:

- Docker
- Kubectl
- Minikube
- Terminal Bash

## O que foi construido

O objetivo desta solução é demonstrar como executar o deploy de uma aplicação containerizada em um cluster Kubernetes local, utilizando Minikube.

## Como aplicar 

Clone este repositório e execute o script deploy.sh na raiz do projeto e em um terminal com provilegios administrativos:

Comando para execução:

```bash
bash ./deploy.sh 
```

## Passo a passo 

### 1. Criação da imagem Docker 

Para a criação da imagem Docker, foi utilizado o Dockerfile disponível no repositório. Foi necessária a alteração da versão do Alpine Linux de 9 para 18, uma vez que a versão anterior não permitia a geração correta da imagem. Isso possivelmente ocorreu devido a incompatibilidades com versões mais recentes de bibliotecas ou dependências utilizadas na aplicação. Também foi ajustado o comando de inicialização no Dockerfile de CMD npm start para CMD ["npm", "start"], garantindo a execução direta do processo, sem shell intermediário, o que melhora o controle dos sinais e a finalização do container.

O processo é feito com os seguintes comandos:

```bash
eval $(minikube docker-env)
docker build -t app-idwall:latest .
```

### 2. Criação dos manifestos Kubernetes

Foram utilizados os seguintes manifestos:

- namespace
- configmap
- deployment
- service
- ingress

A aplicação de todos os manifestos é feita com o comando: 

```bash
kubectl apply -f k8s/
```
### 3. Criação do script deploy

Foi desenvolvido um script Bash que automatiza todo o processo de deploy da aplicação no cluster Kubernetes local utilizando Minikube.

O script executa as seguintes etapas:

- Verifica e inicia o Minikube, caso não esteja ativo;
- Ativa o addon de ingress;
- Inicia o túnel do Minikube para o serviço;
- Constrói a imagem Docker diretamente no ambiente do Minikube;
- Aplica os manifestos Kubernetes (namespace, configmap, deployment, service e ingress);
- Aguarda o rollout do deployment, garantindo que a aplicação esteja devidamente implantada e executando corretamente.

### 4. Verificação dos pods funcionando

Ao final do processo de deploy, é realizada a verificação dos pods para garantir que estão executando corretamente no cluster Kubernetes.

O script inclui o seguinte comando:

```bash
kubectl get pods -n idwall-app
```

### 5. URL de saída

Após a conclusão do deploy, o script exibe automaticamente a URL de acesso à aplicação, utilizando o domínio dinâmico do serviço nip.io.

Acesse em:

```bash
http://app.<MINIKUBE_IP>.nip.io

```

Exemplo: 

```bash
 http://app.192.168.49.2.nip.io 

```

## Como destruir

Execute o comando se desejar encerrar completamente o ambiente:

```bash
chmod +x deploy.sh && ./destroy.sh
```
Importante: certifique-se de estar no diretório raiz do projeto, onde está localizado o arquivo destroy.sh 