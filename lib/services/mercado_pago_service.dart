class MercadoPagoService {
  Future<Map<String, dynamic>> criarPagamento({
    required String clienteId,
    required String faturaId,
    required double valor,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700));

    return {
      'paymentId': 'MP-DEMO-001',
      'status': 'pending',
      'valor': valor,
      'checkoutUrl': 'https://www.mercadopago.com.br/checkout/v1/demo',
      'pixCopiaCola':
          '00020126580014br.gov.bcb.pix0136raiofibra-pagamento-demo520400005303986540599.905802BR5920RAIO FIBRA INTERNET6009PERNAMBUCO62070503***6304ABCD',
    };
  }

  Future<Map<String, dynamic>> consultarPagamento(String paymentId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return {
      'paymentId': paymentId,
      'status': 'pending',
      'mensagem': 'Pagamento aguardando confirmação.',
    };
  }
}
