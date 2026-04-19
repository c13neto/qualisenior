# QualiSenior

CRM para gerenciamento de pacientes e sessões de fisioterapia.

## 🚀 Stack

- **Backend**: Node.js + Express + TypeScript
- **Database**: PostgreSQL + Prisma ORM
- **Frontend**: (em desenvolvimento)

## 📁 Estrutura

```
backend/          # API e lógica de negócio
└── prisma/       # Schema do banco de dados
└── lib/          # Utilitários (Prisma client)

frontend/         # Interface web (em desenvolvimento)

database/         # Docker Compose para o banco
```

## 🔧 Tecnologias

- **Express.js** - Framework web API
- **Prisma** - ORM TypeScript
- **PostgreSQL** - Banco de dados
- **tsx** - TypeScript executor

## 📦 Dependências

Instale as dependências do backend:

```bash
cd backend
npm install
```

## ▶️ Como Rodar

### Desenvolvimento

```bash
cd backend
npm run dev
```

O servidor rodará em `http://localhost:3000`

### Banco de Dados

Inicie o PostgreSQL com Docker:

```bash
docker-compose -f database/compose.yaml up
```

Execute as migrations:

```bash
cd backend
npx prisma migrate dev
```

## 👥 Features

- Gerenciamento de fisioterapeutas e pacientes
- Sistema de roles (Admin, Fisio, Paciente)
- Controle de sessões de fisioterapia
- Relatórios e acompanhamento
- Gestão de contratos e pagamentos
