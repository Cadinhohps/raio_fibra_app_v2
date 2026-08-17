import 'dart:convert';

import 'package:http/http.dart' as http;

class MercadoPagoService {
  static const String baseUrl = 'http://localhost:3000';

  Future<Map<String, dynamic>> criarPagamento({
    required String clienteId,
    required String faturaId,
    required double valor,
  }) async {
    final url = Uri.parse('$baseUrl/mercado-pago/pix');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'clienteId': clienteId,
        'faturaId': faturaId,
        'valor': valor,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode >= 400) {
      throw Exception(data['erro'] ?? 'Erro ao gerar Pix');
    }

    return Map<String, dynamic>.from(data);
  }

  Future<Map<String, dynamic>> consultarPagamento(String pagamentoId) async {
    final url = Uri.parse('$baseUrl/mercado-pago/pagamento/$pagamentoId');

    final response = await http.get(url);
    final data = jsonDecode(response.body);

    if (response.statusCode >= 400) {
      throw Exception(data['erro'] ?? 'Erro ao consultar pagamento');
    }

    return Map<String, dynamic>.from(data);
  }
}