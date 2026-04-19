# 🏥 QualiSenior

> CRM inteligente para gerenciamento de pacientes e sessões de fisioterapia

Um sistema completo para clínicas de fisioterapia que oferece controle de pacientes, agendamento de sessões, gestão de profissionais e acompanhamento de tratamentos.

---

## Tabela de Conteúdos

- [Features](#features)
- [Stack Tecnológico](#stack)
- [Pré-requisitos](#pré-requisitos)
- [Instalação](#instalação)
- [Como Usar](#como-usar)
- [Contribuição](#contribuição)

---

## Features

- ✅ **Gerenciamento de Usuários** - Administradores, fisioterapeutas e pacientes
- ✅ **Sistema de Roles** - Controle de permissões
- ✅ **Gestão de Pacientes** - Perfil completo com histórico e status
- ✅ **Agendamento de Sessões** - Controle de sessões (em progresso, concluídas, canceladas)
- ✅ **Relatórios** - Acompanhamento de tratamentos por fisioterapeuta
- ✅ **Gestão de Contratos** - Suporte para múltiplos tipos de contrato
- ✅ **Controle de Pagamentos** - Status de pagamento

---

## Stack

| Camada | Tecnologia |
| ------ | ---------- |
| **Backend** | Node.js + Express.js + TypeScript |
| **Database** | PostgreSQL + Prisma ORM |
| **Runtime** | tsx (TypeScript executor) |
| **Containerização** | Docker + Docker Compose |
| **Frontend** | (Em desenvolvimento) |

---

## Pré-requisitos

- **Node.js** 18+
- **npm** ou **yarn**
- **Docker** e **Docker Compose**
- **Git**

---

## Instalação

### 1. Clone o repositório

```bash
git clone https://github.com/c13neto/qualisenior.git
cd qualisenior
```

### 2. Configure as variáveis de ambiente

```bash
cd backend
cp .env.example .env
```

Edite o `.env` com suas credenciais do banco de dados:

```env
DATABASE_URL="postgresql://usuario:senha@localhost:5432/database?schema=public"
```

### 3. Inicie o banco de dados

```bash
docker-compose -f database/compose.yaml up -d
```

### 4. Instale dependências e configure o banco

```bash
cd backend
npm install
npx prisma migrate dev
```

---

## Como Usar

### Desenvolvimento (Backend)

```bash
cd backend
npm run dev
```

### Gerenciar banco de dados

#### Ver dados visualmente

```bash
npx prisma studio
```

#### Criar nova migration

```bash
npx prisma migrate dev --name sua_descricao
```

#### Resetar banco de dados (⚠️ Apenas desenvolvimento)

```bash
npx prisma migrate reset
```

---

## Contribuição

Contribuições são bem-vindas! Por favor:

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Add: MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

---

## 📄 Licença

ISC

---

## 📞 Suporte

Para dúvidas ou problemas, abra uma issue no repositório.
