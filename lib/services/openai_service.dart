class OpenAiService {
  Future<String> enviarMensagem({
    required String mensagem,
    required List<Map<String, dynamic>> historico,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    return 'Resposta simulada da IA para: "$mensagem". '
        'Na versão final, essa função enviará a conversa para a API da OpenAI com regras do atendimento da Raio Fibra.';
  }
}
