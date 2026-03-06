# Use uma imagem oficial do Node.js como base (versão leve alpine)
FROM node:20-alpine

# Define o diretório de trabalho dentro do container
WORKDIR /usr/src/app

# Copia os arquivos de dependências do backend
COPY backend/package*.json ./backend/

# Muda para o diretório do backend e instala as dependências
WORKDIR /usr/src/app/backend
RUN npm install

# Volta para o diretório de trabalho raiz do app
WORKDIR /usr/src/app

# Copia o restante do código fonte (backend e frontend)
COPY backend/ ./backend/
COPY frontend/ ./frontend/

# Expõe a porta que a aplicação vai rodar
EXPOSE 3000

# Comando para iniciar a aplicação, executando o server.js no diretorio backend
WORKDIR /usr/src/app/backend
CMD [ "node", "server.js" ]
