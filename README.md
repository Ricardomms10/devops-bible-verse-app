# Bible Verse App - DevOps Version 🚀

Bem-vindo ao repositório do **Bible Verse App**. Esta não é apenas mais uma aplicação web simples; é um ambiente laboratorial desenhado explicitamente para demonstrar conhecimentos sólidos e profissionais de **Engenharia de DevOps, Automação, CI/CD e Infraestrutura como Código (IaC)**.

O objetivo desta aplicação ("Hello World" estilo DevOps) é servir como carga de trabalho (workload) principal e real para a criação de túneis de entrega e estruturas em nuvem modernas.

---

## 🏗️ Arquitetura e Tecnologias

O ecossistema do projeto está estruturado nos seguintes pilares fundamentais:

### 1. Aplicação e Containerização
*   **Backend:** API REST desenvolvida em Node.js (Express.js), fornecendo rotas funcionais e endpoints de Readiness/Liveness Probe (`/api/health`) voltados à orquestração.
*   **Frontend:** Interface de usuário construída utilizando Vanilla HTML, CSS (Glassmorphism design) e JavaScript.
*   **Docker:** O pipeline de construção utiliza um `Dockerfile` enxuto focado em segurança (distribuição `node:20-alpine`) e `docker-compose.yml` para testes ágeis no ambiente do desenvolvedor local.

### 2. Infraestrutura como Código (IaC) - AWS
Todo o ambiente real de nuvem é gerenciado via **Terraform** de maneira declarativa, localizado na pasta `/terraform`:
*   **Provedor AWS:** Construção da infraestrutura principal utilizando o provider da Amazon Web Services (`us-east-1`).
*   **Remote State Back-end:** O estado do nosso Terraform (`terraform.tfstate`) é guardado com segurança de forma remota em um bucket Amazon S3 (`terraform-state-devops-ricardo`).
*   **Instância EC2 e Security Groups:** O código provisiona uma máquina EC2 Linux atrelada a Security Groups devidamente bloqueados (habilitando acesso via SSH/Porta 22 e Tráfego Web/Porta 3000).
*   **Automação (User Data):** A EC2 é provisionada em *Cold Start* efetuando a auto-instalação do Docker e de suas dependências, baixando a imagem mais recente do Container Registry e executando-a automaticamente.

### 3. Integração e Entrega Contínua (CI/CD)
O repositório é equipado com automações de Action robustas localizadas em `.github/workflows/`:
*   **Pipeline de Aplicação (`pipeline.yml`):**
    *   **Build:** Executa um Checkout seguro, efetua o Build da imagem Docker da aplicação e publica de maneira autenticada na nuvem utilizando o **GitHub Container Registry (GHCR)**.
    *   **Deploy (EC2):** Se conecta através de um túnel SSH blindado via Chaves Secretas até a infraestrutura na AWS, puxa a última versão das imagens publicadas e faz um *rolling update* local reiniciando a aplicação rodando.
*   **Pipeline de Infraestrutura (`terraform.yml`):**
    *   Workflow dinâmico do *Terraform* que oferece opções seguras acionáveis manualmente (*Workflow Dispatch*).
    *   Permite a quem opera utilizar os eventos granulares do Terraform remotamente como: `plan`, `apply` e `destroy`, centralizando a gestão em um painel sem necessitar rodar Terraform localmente.

---

## 📂 Estrutura de Diretórios

```
devops-bible-verse-app/
│
├── .github/
│   └── workflows/
│       ├── pipeline.yml     # CI/CD de Construção da Imagem e Deployment
│       └── terraform.yml    # CI/CD de Operações da Infraestrutura
│
├── backend/                 # Código da API e banco de dados JSON em NodeJS
├── frontend/                # SPA de Interface Front-end
├── terraform/               # Todo o código declarativo da Infra AWS
│   ├── backend.tf           # Configurações do Estado Remoto S3
│   ├── main.tf              # Recursos AWS (SG, EC2) e Shell User-Data
│   └── provider.tf          # Configurações do Provedor AWS e Regiões
│
├── docker-compose.yml       # Orquestração simplificada
└── Dockerfile               # Instruções de Containerização do App
```

---

## ⚙️ Como executar localmente
Caso necessite desenvolver, rodar testes ou modificar a aplicação apenas na sua máquina:

**Opção 1 (via Docker - Recomendado 🐳):**
```bash
docker-compose up -d --build
```
Acesse a aplicação no navegador em `http://localhost:3000`.

**Opção 2 (Sem Docker, dependendo apenas do Node):**
Acesse o diretório `backend/`, rode `npm install` e após estar pronto execute `npm start`.

---

## 🔌 API e Referência de Endpoints

*   `GET /api/verse`: Retorna o payload em formato JSON referenciando o versículo diário.
*   `GET /api/version`: Recupera a release atual da aplicação.
*   `GET /api/health`: Healthcheck endpoint para verificação automática de rotas do balanceador de carga, probes Kubernetes ou Load Balancers. Retorna status "ok".
