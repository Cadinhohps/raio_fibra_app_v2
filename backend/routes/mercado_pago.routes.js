const express = require('express');
const mercadoPagoService = require('../services/mercado_pago.service');

const router = express.Router();

router.post('/criar-pagamento', async (req, res) => {
  const payment = await mercadoPagoService.createPayment(req.body);

  res.json(payment);
});

router.get('/status/:paymentId', async (req, res) => {
  const paymentStatus = await mercadoPagoService.getPaymentStatus(
    req.params.paymentId,
  );

  res.json(paymentStatus);
});

module.exports = router;
