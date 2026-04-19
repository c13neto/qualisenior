#!/bin/bash

# Configurações de Caminho
PROJECT_ROOT="/home/adalberto/Dev/qualisenior/backend"
DB_DIR="$PROJECT_ROOT/database"
LOG_FILE="/home/adalberto/Dev/qualisenior/output_prisma-express.log"

# Cores
VERDE='\033[0;32m'
AMARELO='\033[1;33m'
VERMELHO='\033[0;31m'
NC='\033[0m' 

ACAO=$1
NOME=$2

# Função para matar processos da porta 3000 e 5555 (Studio)
limpar_processos() {
    echo -e "${AMARELO}Encerrando processos Node e Prisma Studio...${NC}"
    # Mata o processo que estiver usando a porta da API (3000) e do Studio (5555)
    fuser -k 3000/tcp 51212/tcp > /dev/null 2>&1
    pkill -f "tsx watch" > /dev/null 2>&1
}

if [ -z "$ACAO" ]; then
    echo -e "${VERMELHO}Erro: Argumento faltando!${NC}"
    echo -e "Uso: ./gestao.sh [u | 1 | 0] [nome_migration]"
    exit 1
fi

case "$ACAO" in
    "u" | "U")
        if [ -z "$NOME" ]; then
            echo -e "${VERMELHO}Erro: Você precisa dar um nome para a migration!${NC}"
            echo -e "Exemplo: ./gestao.sh u criacao_tabelas"
            exit 1
        fi
        echo -e "${VERDE}🚀 Atualizando Schema e Migrations...${NC}"
        cd "$PROJECT_ROOT" || exit
        npx prisma generate
        npx prisma migrate dev --name "$NOME"
        ;;

    "1")
        echo -e "${VERDE}🔌 Iniciando Infraestrutura e App...${NC}"
        
        # 1. Sobe o Banco Primeiro
        cd "$DB_DIR" || exit
        docker compose up -d
        
        # 2. Inicia o Studio em Background
        cd "$PROJECT_ROOT" || exit
        nohup npx prisma studio > /dev/null 2>&1 &
        
        # 3. Inicia a API
        echo -e "${AMARELO}Iniciando API em background... (Logs em $LOG_FILE)${NC}"
        nohup npm run dev > "$LOG_FILE" 2>&1 &
        
        echo -e "${VERDE}Tudo online! API: 3000 | Studio: 51212 | DB: 5432${NC}"
        ;;
    
    "0")
        echo -e "${AMARELO}🛑 Desligando tudo...${NC}"
        
        # 1. Para os processos Node/Prisma
        limpar_processos
        
        rm "$LOG_FILE"

        # 2. Derruba o Docker
        cd "$DB_DIR" || exit
        docker compose stop # ou 'down' se quiser remover os containers
        
        echo -e "${VERDE}Ambiente encerrado com sucesso.${NC}"
        ;;

    *)
        echo -e "${VERMELHO}Aviso: '${ACAO}' é inválido.${NC}"
        echo -e "Use: ${VERDE}u${NC} (Update), ${VERDE}1${NC} (Up) ou ${VERDE}0${NC} (Down)"
        ;;
esac