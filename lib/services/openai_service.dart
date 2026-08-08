import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:raio_fibra_app_v2/core/api_config.dart';

class OpenAiService {
  static const Duration _timeout = Duration(seconds: 6);

  Future<String> enviarMensagem({
    required String mensagem,
    required List<Map<String, dynamic>> historico,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('${ApiConfig.baseUrl}/openai/chat'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'message': mensagem, 'history': historico}),
          )
          .timeout(_timeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final reply = data['reply'];

        if (reply is String && reply.isNotEmpty) {
          return reply;
        }
      }
    } catch (_) {}

    return _respostaLocal(mensagem);
  }

  String _respostaLocal(String mensagem) {
    final texto = mensagem.toLowerCase();

    if (texto.contains('sem internet') ||
        texto.contains('caiu') ||
        texto.contains('offline') ||
        texto.contains('sem conexao')) {
      return 'Entendi que voce esta sem internet. Verifique a luz LOS do roteador, reinicie o equipamento por 30 segundos e confira os cabos. Se continuar, posso orientar a abertura de chamado tecnico.';
    }

    if (texto.contains('lenta') ||
        texto.contains('lentidao') ||
        texto.contains('devagar') ||
        texto.contains('travando')) {
      return 'Para internet lenta, teste perto do roteador, feche downloads e videos, reinicie o equipamento e faca um teste de velocidade. Se ficar abaixo do plano, abrimos um chamado com prioridade.';
    }

    if (texto.contains('fatura') ||
        texto.contains('pix') ||
        texto.contains('boleto') ||
        texto.contains('segunda via')) {
      return 'Posso ajudar com sua fatura. A area de Faturas gera segunda via, PIX copia e cola e abre o pagamento simulado do Mercado Pago.';
    }

    if (texto.contains('chamado') || texto.contains('suporte')) {
      return 'Antes de abrir chamado, me diga o problema, quando comecou, se ja reiniciou o roteador e se a luz LOS esta vermelha. Assim o suporte recebe tudo completo.';
    }

    if (texto.contains('wifi') ||
        texto.contains('wi-fi') ||
        texto.contains('senha') ||
        texto.contains('roteador')) {
      return 'Para Wi-Fi, confira a rede, a senha, o local do roteador e a quantidade de dispositivos conectados. A area Meu Wi-Fi esta pronta para integrar esses dados.';
    }

    if (texto.contains('plano') ||
        texto.contains('upgrade') ||
        texto.contains('promocao')) {
      return 'Temos opcoes de upgrade e promocoes. Para demonstracao, posso sugerir um plano superior conforme seu perfil de uso e beneficios comerciais.';
    }

    return 'Sou a Raio IA e posso ajudar com sem internet, internet lenta, fatura, PIX, boleto, suporte, chamado, Wi-Fi, plano, upgrade e promocao. Me diga o que voce precisa.';
  }
}
