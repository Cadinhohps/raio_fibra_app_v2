async function findClientByCpf(cpf) {
  return {
    id: 'CLI001',
    nome: 'Ricardo',
    cpf,
    plano: '600 Mega',
    statusContrato: 'Ativo',
    statusConexao: 'Online',
  };
}

async function findInvoicesByClientId(clienteId) {
  return [
    {
      id: 'FAT001',
      clienteId,
      competencia: 'Julho/2026',
      valor: 99.9,
      vencimento: '10/07/2026',
      status: 'Em aberto',
      pixCopiaCola:
        '00020126580014br.gov.bcb.pix0136raiofibra-pagamento-demo520400005303986540599.905802BR5920RAIO FIBRA INTERNET6009PERNAMBUCO62070503***6304ABCD',
      pdfUrl: 'https://raiofibra.example/faturas/FAT001.pdf',
    },
    {
      id: 'FAT002',
      clienteId,
      competencia: 'Junho/2026',
      valor: 99.9,
      vencimento: '10/06/2026',
      status: 'Pago',
      pixCopiaCola: '',
      pdfUrl: 'https://raiofibra.example/faturas/FAT002.pdf',
    },
  ];
}

async function createTicket({ clienteId, categoria, descricao, prioridade }) {
  return {
    protocolo: '#RF1030',
    clienteId,
    categoria,
    descricao,
    prioridade,
    status: 'Aberto',
    sla: prioridade === 'Alta' ? 'ate 2h uteis' : 'ate 4h uteis',
    criadoEm: new Date().toISOString(),
  };
}

module.exports = {
  findClientByCpf,
  findInvoicesByClientId,
  createTicket,
};
