import 'dotenv/config';
import express, { Request, Response, NextFunction } from 'express';
import helmet from 'helmet';
import cors from 'cors';
import rateLimit from 'express-rate-limit';
import cookieSession from 'cookie-session';
import { prisma } from "./lib/prisma";

const app = express();
const PORT = process.env.PORT || 3000;

app.set('trust proxy', 1);

app.use(helmet());

if (process.env.NODE_ENV === 'production' && !process.env.FRONTEND_URL) {
  throw new Error('FRONTEND_URL não definido em produção!');
}

app.use(cors({
  origin: process.env.NODE_ENV === 'production' ? process.env.FRONTEND_URL : 'http://localhost:5173',
  credentials: true,
}));

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
});
app.use('/qs', limiter);

app.use(express.json());

if (!process.env.COOKIE_SECRET) {
  throw new Error('COOKIE_SECRET não definido no .env!');
}
app.use(cookieSession({
  name: 'qualisenior_session',
  keys: [process.env.COOKIE_SECRET!],
  secure: process.env.NODE_ENV === 'production',
  httpOnly: true,
  sameSite: 'strict',
  maxAge: 8 * 60 * 60 * 1000,
}));

app.get('/qs/test', (_req: Request, res: Response) => {
  res.json({ status: 'API Blindada e Operacional' });
});

app.use((_req: Request, res: Response, _next: NextFunction) => {
  res.status(404).json({ erro: "Rota não encontrada. Verifique a URL." });
});

app.use((err: Error, _req: Request, res: Response, _next: NextFunction) => {
  console.error("Erro fatal:", err.stack);
  res.status(500).json({ erro: "Erro interno no servidor." });
});


const server = app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});

const shutdown = async () => {
  console.log('Desligando servidor graciosamente...');

  server.close(async () => {
    console.log('Servidor HTTP fechado.');
    await prisma.$disconnect();
    console.log('Conexão com o banco de dados encerrada.');
    process.exit(0);
  });
};

process.on('SIGTERM', shutdown);
process.on('SIGINT', shutdown);
