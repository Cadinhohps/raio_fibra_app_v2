const express = require('express');
const sgpService = require('../services/sgp.service');

const router = express.Router();

router.post('/cliente', async (req, res) => {
  const { cpf } = req.body;
  const client = await sgpService.findClientByCpf(cpf);

  res.json(client);
});

router.post('/faturas', async (req, res) => {
  const { clienteId } = req.body;
  const invoices = await sgpService.findInvoicesByClientId(clienteId);

  res.json(invoices);
});

router.post('/chamados', async (req, res) => {
  const ticket = await sgpService.createTicket(req.body);

  res.json(ticket);
});

module.exports = router;
