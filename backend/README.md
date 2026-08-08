# Raio Fibra IA API

Backend Express simulado para o MVP Raio Fibra IA. Ele prepara integracoes futuras com OpenAI/ChatGPT, SGP e Mercado Pago sem usar chaves reais.

## Instalacao

```bash
cd backend
npm install
npm run dev
```

Por padrao, a API roda em `http://localhost:3000`.

## Scripts

- `npm start`: inicia `server.js`.
- `npm run dev`: inicia `server.js`.

## Rotas Disponiveis

- `GET /health`
- `POST /openai/chat`
- `POST /sgp/cliente`
- `POST /sgp/faturas`
- `POST /sgp/chamados`
- `POST /mercado-pago/criar-pagamento`
- `GET /mercado-pago/status/:paymentId`

## Exemplos

`POST /openai/chat`

```json
{
  "message": "sem internet",
  "history": []
}
```

`POST /sgp/cliente`

```json
{
  "cpf": "00000000000"
}
```

`POST /sgp/chamados`

```json
{
  "clienteId": "CLI001",
  "categoria": "Sem internet",
  "descricao": "Cliente sem conexao",
  "prioridade": "Normal"
}
```

`POST /mercado-pago/criar-pagamento`

```json
{
  "clienteId": "CLI001",
  "faturaId": "FAT001",
  "valor": 99.9
}
```

## Variaveis `.env`

```env
PORT=3000
OPENAI_API_KEY=
SGP_BASE_URL=
SGP_TOKEN=
MERCADO_PAGO_ACCESS_TOKEN=
```

Copie `.env.example` para `.env` quando for ativar integracoes reais.

## Observacao

Todas as respostas atuais sao simuladas e seguras para demonstracao comercial e testes controlados.
