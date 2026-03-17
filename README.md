# Desafio DevOps - Hubii

Projeto desenvolvido como solução para o desafio técnico DevOps, contemplando aplicação em Python, containerização com Docker, orquestração com Kubernetes, pipeline CI/CD com GitHub Actions, infraestrutura como código com Terraform e boas práticas de segurança.

---

## Tecnologias Utilizadas

- Python 3.11 + Flask
- Docker
- Kubernetes
- GitHub Actions
- Trivy (scan de vulnerabilidades)
- Terraform (AWS S3)

---

## Estrutura do Projeto

├── app.py # Aplicação Python
├── requirements.txt # Dependências Python
├── Dockerfile # Containerização da aplicação
├── SECURITY.md # Documento de segurança
├── .env.example # Modelo de variáveis de ambiente
├── k8s/
│ ├── deployment.yaml # Deployment Kubernetes
│ ├── service.yaml # Service Kubernetes
│ └── ingress.yaml # Ingress Kubernetes
├── terraform/
│ ├── main.tf # Recurso S3 + Provider AWS
│ ├── variables.tf # Variáveis do Terraform
│ └── outputs.tf # Outputs do Terraform
└── .github/
└── workflows/
└── ci.yml # Pipeline CI/CD



---

## Como Executar o Projeto

### Pré-requisitos

- Python 3.11+
- Docker
- Kubectl + Kubernetes (Docker Desktop)

---

### Parte 1 — Aplicação local

```bash
pip install -r requirements.txt
cp .env.example .env
python app.py


Acesse: http://localhost:8080/health
Resposta esperada:

{
  "status": "ok",
  "version": "1.0.0",
  "environment": "development"
}
Parte 2 — Docker

docker build -t minha-app .
docker run -p 8080:8080 -e APP_ENV=production minha-app

Acesse: http://localhost:8080/health

Parte 3 — Kubernetes

kubectl apply -f k8s/
kubectl get pods
kubectl port-forward service/minha-app 9090:80

Acesse: http://localhost:9090/health

Decisões Técnicas
Aplicação
Flask foi escolhido por ser um micro-framework minimalista, ideal para uma aplicação com endpoint único

python-dotenv para carregar variáveis de ambiente localmente sem alterar o código

Dockerfile
Imagem base python:3.11-slim — oficial, leve e sem pacotes desnecessários

Container roda como usuário não-root (appuser) por segurança

apt-get upgrade e atualização de pip/setuptools/wheel para eliminar vulnerabilidades HIGH identificadas pelo Trivy

COPY requirements.txt antes do código para aproveitar o cache de layers do Docker

Kubernetes
readinessProbe garante que o tráfego só chega ao Pod quando a aplicação estiver pronta

livenessProbe reinicia automaticamente o container em caso de falha

requests e limits de CPU e memória definidos para evitar consumo descontrolado de recursos

Variável APP_ENV injetada diretamente no Deployment, sem arquivos .env

Pipeline CI/CD
Jobs em sequência: lint → build → scan — falha em cascata

Flake8 para validação de estilo e erros de sintaxe Python

Trivy configurado para falhar apenas em vulnerabilidades HIGH e CRITICAL

Terraform
Separação em main.tf, variables.tf e outputs.tf seguindo convenção padrão

Bucket S3 com versionamento habilitado e acesso público bloqueado por padrão

Possíveis Melhorias em Cenário Real
Imagem distroless: substituir python:3.11-slim por imagem distroless para reduzir a superfície de ataque

Multi-stage build: separar estágio de build do estágio de execução no Dockerfile

Kubernetes Secrets + External Secrets Operator: integrar com AWS Secrets Manager ou HashiCorp Vault

HorizontalPodAutoscaler: escalar automaticamente os Pods conforme carga

Health check mais robusto: incluir verificação de dependências externas no endpoint /health

Terraform remote state: armazenar o estado em bucket S3 com DynamoDB para lock

Ambientes separados: criar workspaces Terraform para dev, staging e production

SAST no pipeline: adicionar análise estática de segurança com Bandit para código Python