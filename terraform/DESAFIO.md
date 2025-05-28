# Desafio 01: Terraform

## Preparação de ambiente 

Ferramentas necessárias para executar este projeto:

- Terraform (>= 1.5)
- AWS CLI configurado com suas credenciais
- Permissão para criar recursos na AWS (EC2 e Security Group)
- Terminal com bash

## O que foi construido

O objetivo desta solução é provisionar uma instância EC2 na AWS utilizando Terraform.

## Como aplicar 

Clone este repositório, acesse a pasta infra e execute o script apply.sh em um terminal com provilegios avançados. Passe como parâmetros o range de IP liberado para SSH (<SSH_CIDR>) e a região da AWS (<REGION>).

Comando para execução: 

```bash
bash ./apply.sh <SSH_CIDR> <REGION>
```

Ao final, será exibido o IP público da instância criada.

## Passo a passo 

### 1. Criação dos módulos Terraform 

Foram desenvolvidos dois módulos:

- Security Group
- EC2 Instance

### 2. Instalação do Apache

Na inicialização da instância, foi utilizado um script user_data que executa:

- Atualização dos pacotes da Amazon Linux 2
- Instalação do Docker
- Inicialização do serviço Docker
- Execução do container oficial do Apache (httpd) na porta 80
- Isso permite acessar a página padrão do Apache via HTTP diretamente no IP público da instância.


### 3. Script de Apply

Automatiza todo o ciclo de provisionamento:

- Inicialização o Terraform
- Cria o plano
- Aplicação as mudanças
- Exibi o IP da instância

### 4. URL de saída

Após a execução, acesse no navegador:

```bash
http://<IP_PÚBLICO_DA_INSTÂNCIA>
```

## Como destruir

Execute o script destroy.sh na pasta infra. Passe como parâmetros o range de IP liberado para SSH (<SSH_CIDR>) e a região da AWS (<REGION>).

Comando para execução: 

```bash
bash ./destroy.sh <SSH_CIDR> <REGION>
```

Importante: Lembre-se de destruir os recursos assim que finalizar os testes para evitar custos na AWS.