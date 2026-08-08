import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:raio_fibra_app_v2/core/api_config.dart';

class MercadoPagoService {
  static const Duration _timeout = Duration(seconds: 4);

  Future<Map<String, dynamic>> criarPagamento({
    required String clienteId,
    required String faturaId,
    required double valor,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/mercado-pago/criar-pagamento'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'clienteId': clienteId,
              'faturaId': faturaId,
              'valor': valor,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}

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
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/mercado-pago/status/$paymentId'))
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}

    return {
      'paymentId': paymentId,
      'status': 'pending',
      'mensagem': 'Pagamento aguardando confirmacao.',
    };
  }
}
