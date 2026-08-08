class RaioIaService {
  String responder(String mensagem) {
    final texto = mensagem.toLowerCase();

    if (texto.contains('sem internet') ||
        texto.contains('caiu') ||
        texto.contains('offline') ||
        texto.contains('nao funciona')) {
      return 'Entendi. Vamos fazer uma triagem rapida antes de abrir chamado.\n\n'
          '1. Verifique se a luz LOS do roteador esta vermelha ou piscando.\n'
          '2. Reinicie o roteador da tomada por 30 segundos.\n'
          '3. Confira se os cabos estao bem encaixados.\n\n'
          'Se apos esses testes continuar sem internet, posso orientar a abertura de chamado tecnico.';
    }

    if (texto.contains('lenta') ||
        texto.contains('devagar') ||
        texto.contains('travando') ||
        texto.contains('lentidao')) {
      return 'Certo. Para internet lenta, vamos verificar alguns pontos:\n\n'
          '1. Teste perto do roteador.\n'
          '2. Feche videos, downloads e jogos.\n'
          '3. Reinicie o roteador.\n'
          '4. Faca um teste de velocidade.\n\n'
          'Se o resultado continuar muito abaixo do plano, podemos abrir chamado com prioridade.';
    }

    if (texto.contains('boleto') ||
        texto.contains('fatura') ||
        texto.contains('segunda via') ||
        texto.contains('pix') ||
        texto.contains('pagar')) {
      return 'Posso ajudar com isso. Va na aba Faturas para consultar a fatura atual, PIX copia e cola, QR Code e botao de pagamento.';
    }

    if (texto.contains('chamado') ||
        texto.contains('tecnico') ||
        texto.contains('suporte')) {
      return 'Antes de abrir o chamado, preciso entender melhor: qual e o problema, quando comecou, se ja reiniciou o roteador e se a luz LOS esta vermelha.';
    }

    if (texto.contains('plano') ||
        texto.contains('upgrade') ||
        texto.contains('velocidade') ||
        texto.contains('promocao')) {
      return 'Temos opcoes de upgrade e promocoes disponiveis. Na versao final, vou consultar os planos ativos do provedor e sugerir o melhor plano para seu perfil de uso.';
    }

    if (texto.contains('wifi') ||
        texto.contains('wi-fi') ||
        texto.contains('senha') ||
        texto.contains('roteador')) {
      return 'Para problemas de Wi-Fi, verifique se esta conectado na rede correta, se a senha mudou, se o roteador esta em local aberto e quantos dispositivos estao conectados.';
    }

    return 'Entendi. Vou tentar te ajudar antes de abrir chamado. Voce pode falar sobre sem internet, internet lenta, fatura, PIX, suporte, mudanca de plano ou Wi-Fi.';
  }
}
