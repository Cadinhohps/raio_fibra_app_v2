import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:raio_fibra_app_v2/core/api_config.dart';

class SgpService {
  static const Duration _timeout = Duration(seconds: 4);

  Future<Map<String, dynamic>> buscarClientePorCpf(String cpf) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/sgp/cliente'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'cpf': cpf}),
          )
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}

    return {
      'id': 'CLI001',
      'nome': 'Ricardo',
      'cpf': cpf,
      'plano': '600 Mega',
      'statusContrato': 'Ativo',
      'statusConexao': 'Online',
    };
  }

  Future<List<Map<String, dynamic>>> buscarFaturas(String clienteId) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/sgp/faturas'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'clienteId': clienteId}),
          )
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as List<dynamic>;
        return data.cast<Map<String, dynamic>>();
      }
    } catch (_) {}

    return [
      {
        'id': 'FAT001',
        'clienteId': clienteId,
        'competencia': 'Julho/2026',
        'valor': 99.90,
        'vencimento': '10/07/2026',
        'status': 'Em aberto',
        'pixCopiaCola':
            '00020126580014br.gov.bcb.pix0136raiofibra-pagamento-demo520400005303986540599.905802BR5920RAIO FIBRA INTERNET6009PERNAMBUCO62070503***6304ABCD',
        'pdfUrl': 'https://raiofibra.example/faturas/FAT001.pdf',
      },
      {
        'id': 'FAT002',
        'clienteId': clienteId,
        'competencia': 'Junho/2026',
        'valor': 99.90,
        'vencimento': '10/06/2026',
        'status': 'Pago',
        'pixCopiaCola': '',
        'pdfUrl': 'https://raiofibra.example/faturas/FAT002.pdf',
      },
      {
        'id': 'FAT003',
        'clienteId': clienteId,
        'competencia': 'Maio/2026',
        'valor': 99.90,
        'vencimento': '10/05/2026',
        'status': 'Pago',
        'pixCopiaCola': '',
        'pdfUrl': 'https://raiofibra.example/faturas/FAT003.pdf',
      },
    ];
  }

  Future<Map<String, dynamic>> abrirChamado({
    required String clienteId,
    required String categoria,
    required String descricao,
    required String prioridade,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/sgp/chamados'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'clienteId': clienteId,
              'categoria': categoria,
              'descricao': descricao,
              'prioridade': prioridade,
            }),
          )
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}

    return {
      'protocolo': '#RF1030',
      'clienteId': clienteId,
      'categoria': categoria,
      'descricao': descricao,
      'prioridade': prioridade,
      'status': 'Aberto',
      'sla': prioridade == 'Alta' ? 'ate 2h uteis' : 'ate 4h uteis',
      'criadoEm': DateTime.now().toIso8601String(),
    };
  }
}
