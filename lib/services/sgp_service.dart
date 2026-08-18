import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:raio_fibra_app_v2/core/api_config.dart';

class SgpService {
  static const Duration _timeout = Duration(seconds: 4);

  Future<Map<String, dynamic>> buscarClientePorCpf(String cpf) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/sgp/cliente/$cpf'))
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}

    return {
      'id': 'CLI001',
      'nome': 'Ricardo',
      'cpf': cpf,
      'plano': 'Plano 600 Mega',
      'status': 'Ativo',
      'statusConexao': 'Online',
      'endereco': 'Rua Exemplo, 123',
      'vencimento': '10',
    };
  }

  Future<List<Map<String, dynamic>>> buscarFaturas(String clienteId) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/sgp/faturas/$clienteId'))
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as List<dynamic>;
        return data.cast<Map<String, dynamic>>();
      }
    } catch (_) {}

    return [
      {
        'id': 'FAT-JUL-2026',
        'clienteId': clienteId,
        'competencia': 'Julho/2026',
        'valor': 'R\$ 99,90',
        'vencimento': '10/07/2026',
        'status': 'Pendente',
        'estaPago': false,
      },
      {
        'id': 'FAT-JUN-2026',
        'clienteId': clienteId,
        'competencia': 'Junho/2026',
        'valor': 'R\$ 99,90',
        'vencimento': '10/06/2026',
        'status': 'Pago',
        'estaPago': true,
      },
    ];
  }

  Future<Map<String, dynamic>> buscarStatusCliente(String clienteId) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/sgp/status/$clienteId'))
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      }
    } catch (_) {}

    return {
      'clienteId': clienteId,
      'status': 'Ativo',
      'statusConexao': 'Online',
      'plano': 'Plano 600 Mega',
    };
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
