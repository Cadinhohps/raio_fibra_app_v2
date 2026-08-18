const express = require('express');

const router = express.Router();

const clienteSimulado = {
  id: 'CLI001',
  nome: 'Ricardo',
  cpf: '00000000000',
  plano: 'Plano 600 Mega',
  status: 'Ativo',
  statusConexao: 'Online',
  endereco: 'Rua Exemplo, 123',
  vencimento: '10',
};

const faturasSimuladas = [
  {
    id: 'FAT-JUL-2026',
    clienteId: 'CLI001',
    competencia: 'Julho/2026',
    valor: 'R$ 99,90',
    vencimento: '10/07/2026',
    status: 'Pendente',
    estaPago: false,
  },
  {
    id: 'FAT-JUN-2026',
    clienteId: 'CLI001',
    competencia: 'Junho/2026',
    valor: 'R$ 99,90',
    vencimento: '10/06/2026',
    status: 'Pago',
    estaPago: true,
  },
];

router.get('/cliente/:cpf', (req, res) => {
  const { cpf } = req.params;

  if (cpf !== clienteSimulado.cpf) {
    return res.status(404).json({
      erro: 'Cliente não encontrado',
    });
  }

  return res.json(clienteSimulado);
});

router.get('/faturas/:clienteId', (req, res) => {
  const { clienteId } = req.params;

  const faturas = faturasSimuladas.filter(
    (fatura) => fatura.clienteId === clienteId,
  );

  return res.json(faturas);
});

router.get('/status/:clienteId', (req, res) => {
  const { clienteId } = req.params;

  if (clienteId !== clienteSimulado.id) {
    return res.status(404).json({
      erro: 'Cliente não encontrado',
    });
  }

  return res.json({
    clienteId,
    status: clienteSimulado.status,
    statusConexao: clienteSimulado.statusConexao,
    plano: clienteSimulado.plano,
  });
});

module.exports = router;