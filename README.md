# DevOps Bible Verse App

Uma aplicação web simples ("Hello World" estilo DevOps) que exibe versículos bíblicos aleatórios, servindo como base para projetos de portfólio de DevOps. A aplicação inclui um backend em Node.js (Express) e um frontend em HTML/CSS/JS puro, projetados para serem facilmente containerizados e implantados através de pipelines CI/CD em ambientes como Kubernetes.

## Estrutura do Projeto

```
devops-bible-verse-app
│
├── backend/          # API RESTful em Node.js/Express
│   ├── server.js     # Ponto de entrada do backend
│   ├── verses.json   # Banco de dados de versículos em JSON
│   └── package.json  # Dependências do backend
│
├── frontend/         # Interface de usuário (SPA simples)
│   ├── index.html    # Estrutura da página principal
│   ├── style.css     # Estilos modernos da interface
│   └── script.js     # Lógica para buscar versículos da API
│
├── Dockerfile        # Instruções para construir a imagem Docker
├── docker-compose.yml # Orquestração local simplificada com Docker Compose
└── README.md         # Esta documentação
```

## Endpoints da API

O backend fornece os seguintes endpoints úteis:

- `GET /api/verse`: Retorna um versículo bíblico aleatório.
  ```json
  {
    "verse": "Tudo posso naquele que me fortalece. Filipenses 4:13"
  }
  ```
- `GET /api/health`: Utilizado para verificações de integridade (Health Check), essencial para Docker e Kubernetes (Liveness/Readiness probes).
  ```json
  {
    "status": "ok"
  }
  ```
- `GET /api/version`: Retorna a versão da API.
  ```json
  {
    "version": "1.0.0"
  }
  ```

## Como Executar Localmente (Sem Docker)

Pré-requisitos: Ter o [Node.js](https://nodejs.org/) instalado.

1. Navegue até o diretório do backend:
   ```bash
   cd backend
   ```
2. Instale as dependências:
   ```bash
   npm install
   ```
3. Inicie o servidor:
   ```bash
   npm start
   ```
4. Acesse a aplicação no navegador em `http://localhost:3000`.

## Como Executar com Docker 🐳

A maneira mais fácil e recomendada de executar esta aplicação em um ambiente isolado.

Pré-requisitos: Ter o [Docker](https://www.docker.com/) e [Docker Compose](https://docs.docker.com/compose/) instalados.

1. Na raiz do projeto, execute o comando:
   ```bash
   docker-compose up -d --build
   ```
2. Acesse a aplicação no navegador em `http://localhost:3000`.
3. Para parar e remover os containers:
   ```bash
   docker-compose down
   ```

## Próximos Passos (Evolução DevOps)

Este projeto foi desenhado propositadamente simples e desacoplado para que possa servir de "cobaia" para implementação de práticas e ferramentas DevOps, como:
- [ ] Criação de manifestos de **Kubernetes** (Deployment, Service, ConfigMap).
- [ ] Setup de **Terraform** para provisionar infraestrutura na Nuvem (Ex: AWS EKS, GCP GKE, DigitalOcean).
- [ ] Implementação de **CI/CD** usando GitHub Actions ou GitLab CI para efetuar build da imagem Docker, rodar testes de integridade e realizar deploy.
- [ ] Monitoramento com **Prometheus & Grafana** consumindo dados do host e pods.
