const express = require('express');
const fs = require('fs');
const path = require('path');
const { MercadoPagoConfig, Payment } = require('mercadopago');

const router = express.Router();

const client = new MercadoPagoConfig({
  accessToken: process.env.MP_ACCESS_TOKEN,
});

const payment = new Payment(client);

const pagamentosPath = path.join(__dirname, '..', 'data', 'pagamentos.json');

function carregarPagamentos() {
  try {
    if (!fs.existsSync(pagamentosPath)) {
      fs.writeFileSync(pagamentosPath, '{}');
    }

    const conteudo = fs.readFileSync(pagamentosPath, 'utf8');
    return JSON.parse(conteudo || '{}');
  } catch (error) {
    console.error('Erro ao carregar pagamentos:', error);
    return {};
  }
}

function salvarPagamentos(pagamentos) {
  fs.writeFileSync(pagamentosPath, JSON.stringify(pagamentos, null, 2));
}

function salvarStatusPagamento(dados) {
  const pagamentos = carregarPagamentos();

  pagamentos[dados.external_reference || dados.id] = {
    id: dados.id,
    status: dados.status,
    status_detail: dados.status_detail,
    external_reference: dados.external_reference,
    atualizado_em: new Date().toISOString(),
  };

  salvarPagamentos(pagamentos);
}

router.post('/pix', async (req, res) => {
  try {
    if (!process.env.MP_ACCESS_TOKEN) {
      return res.status(500).json({
        erro: 'MP_ACCESS_TOKEN não configurado no arquivo .env',
      });
    }

    const {
      valor = 99.9,
      descricao = 'Fatura Raio Fibra Telecom',
      email = 'cliente@email.com',
      nome = 'Ricardo',
      sobrenome = 'Cliente',
      cpf = '00000000000',
      faturaId = 'FAT-JUL-2026',
    } = req.body || {};

    const resposta = await payment.create({
      body: {
        transaction_amount: Number(valor),
        description: descricao,
        payment_method_id: 'pix',
        external_reference: faturaId,
        payer: {
          email,
          first_name: nome,
          last_name: sobrenome,
          identification: {
            type: 'CPF',
            number: cpf,
          },
        },
      },
    });

    salvarStatusPagamento({
      id: resposta.id,
      status: resposta.status,
      status_detail: resposta.status_detail,
      external_reference: resposta.external_reference,
    });

    return res.json({
      id: resposta.id,
      status: resposta.status,
      status_detail: resposta.status_detail,
      external_reference: resposta.external_reference,
      qr_code: resposta.point_of_interaction?.transaction_data?.qr_code || '',
      qr_code_base64:
        resposta.point_of_interaction?.transaction_data?.qr_code_base64 || '',
      ticket_url:
        resposta.point_of_interaction?.transaction_data?.ticket_url || '',
    });
  } catch (error) {
    console.error('Erro Mercado Pago Pix:', error);

    return res.status(500).json({
      erro: 'Erro ao gerar Pix Mercado Pago',
      detalhe: error.message,
      causa: error.cause || null,
    });
  }
});

router.get('/pagamento/:id', async (req, res) => {
  try {
    const resposta = await payment.get({
      id: req.params.id,
    });

    salvarStatusPagamento({
      id: resposta.id,
      status: resposta.status,
      status_detail: resposta.status_detail,
      external_reference: resposta.external_reference,
    });

    return res.json({
      id: resposta.id,
      status: resposta.status,
      status_detail: resposta.status_detail,
      external_reference: resposta.external_reference,
    });
  } catch (error) {
    console.error('Erro ao consultar pagamento:', error);

    return res.status(500).json({
      erro: 'Erro ao consultar pagamento',
      detalhe: error.message,
      causa: error.cause || null,
    });
  }
});

router.get('/fatura/:faturaId/status', async (req, res) => {
  const pagamentos = carregarPagamentos();
  const pagamento = pagamentos[req.params.faturaId];

  if (!pagamento) {
    return res.json({
      faturaId: req.params.faturaId,
      status: 'nao_encontrado',
      mensagem: 'Nenhum pagamento encontrado para esta fatura.',
    });
  }

  return res.json({
    faturaId: req.params.faturaId,
    pagamento,
  });
});

router.post('/webhook', async (req, res) => {
  try {
    console.log('Webhook Mercado Pago recebido:', req.body);
    console.log('Query Mercado Pago:', req.query);

    const pagamentoId =
      req.body?.data?.id ||
      req.body?.id ||
      req.query?.['data.id'] ||
      req.query?.id;

    if (!pagamentoId) {
      return res.status(200).json({
        recebido: true,
        mensagem: 'Webhook recebido sem ID de pagamento.',
      });
    }

    const resposta = await payment.get({
      id: pagamentoId,
    });

    const pagamentoAtualizado = {
      id: resposta.id,
      status: resposta.status,
      status_detail: resposta.status_detail,
      external_reference: resposta.external_reference,
    };

    salvarStatusPagamento(pagamentoAtualizado);

    console.log('Pagamento consultado pelo webhook:', pagamentoAtualizado);

    return res.status(200).json({
      recebido: true,
      pagamento: pagamentoAtualizado,
    });
  } catch (error) {
    console.error('Erro no webhook Mercado Pago:', error);

    return res.status(200).json({
      recebido: true,
      erro: error.message,
      causa: error.cause || null,
    });
  }
});

module.exports = router;