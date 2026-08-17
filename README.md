# Raio Fibra Telecom

App Flutter multiplataforma para provedores de internet, preparado como MVP de demonstracao comercial e testes reais controlados. O projeto combina aplicativo cliente em Flutter com backend Node.js separado para futuras integracoes com OpenAI/ChatGPT, SGP e Mercado Pago.

## Objetivo

Centralizar autoatendimento, faturas, pagamento, suporte, abertura de chamados, beneficios e atendimento por IA em uma experiencia premium para Android, Web, notebook, PC e tablet.

## Arquitetura

- `lib/`: aplicativo Flutter.
- `lib/screens/`: telas do app, incluindo Home, Faturas, Pagamento, Suporte, Abrir Chamado, Raio IA, Vantagens, Perfil e telas extras do MVP.
- `lib/services/`: camada de integracao HTTP com fallback simulado.
- `lib/core/api_config.dart`: URL base da API local.
- `backend/`: API Express simulada para evoluir integracoes reais.

## Rodar Flutter Web

```bash
flutter pub get
flutter run -d chrome
```

## Rodar Android

```bash
flutter pub get
flutter run
```

Use um emulador ou dispositivo conectado.

## Rodar Backend

```bash
cd backend
npm install
npm run dev
```

API local: `http://localhost:3000`.

## Rotas Backend

- `GET /health`
- `POST /openai/chat`
- `POST /sgp/cliente`
- `POST /sgp/faturas`
- `POST /sgp/chamados`
- `POST /mercado-pago/criar-pagamento`
- `GET /mercado-pago/status/:paymentId`

## Integracoes Futuras

- OpenAI/ChatGPT para atendimento real com regras do provedor.
- SGP para consulta real de cliente, contrato, conexao, faturas e chamados.
- Mercado Pago para checkout, PIX e confirmacao de pagamento.
- Autenticacao segura por cliente.
- Push notifications e acompanhamento de SLA em tempo real.

## Aviso

OpenAI, SGP e Mercado Pago ainda estao simulados. Nao ha chaves reais no Flutter nem no backend. Use `backend/.env.example` como base para variaveis futuras.

## Proximos Passos Para Producao

- Criar `.env` no backend com credenciais reais.
- Implementar autenticacao e autorizacao.
- Validar CPF, contrato e titularidade.
- Trocar respostas simuladas pelos endpoints reais.
- Configurar ambiente de deploy, logs e monitoramento.
- Revisar seguranca antes de liberar pagamentos reais.
