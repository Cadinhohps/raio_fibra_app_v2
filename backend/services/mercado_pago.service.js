async function createPayment({ clienteId, faturaId, valor }) {
  return {
    paymentId: 'MP-DEMO-001',
    clienteId,
    faturaId,
    status: 'pending',
    valor,
    checkoutUrl: 'https://www.mercadopago.com.br/checkout/v1/demo',
    pixCopiaCola:
      '00020126580014br.gov.bcb.pix0136raiofibra-pagamento-demo520400005303986540599.905802BR5920RAIO FIBRA INTERNET6009PERNAMBUCO62070503***6304ABCD',
  };
}

async function getPaymentStatus(paymentId) {
  return {
    paymentId,
    status: 'pending',
    mensagem: 'Pagamento aguardando confirmacao.',
  };
}

module.exports = {
  createPayment,
  getPaymentStatus,
};
