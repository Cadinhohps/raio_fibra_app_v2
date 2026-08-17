const express = require('express');
const { MercadoPagoConfig, Payment } = require('mercadopago');

const router = express.Router();

const client = new MercadoPagoConfig({
  accessToken: process.env.MP_ACCESS_TOKEN,
});

const payment = new Payment(client);

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

    console.log('Pagamento consultado pelo webhook:', {
      id: resposta.id,
      status: resposta.status,
      status_detail: resposta.status_detail,
      external_reference: resposta.external_reference,
    });

    return res.status(200).json({
      recebido: true,
      pagamento: {
        id: resposta.id,
        status: resposta.status,
        status_detail: resposta.status_detail,
        external_reference: resposta.external_reference,
      },
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