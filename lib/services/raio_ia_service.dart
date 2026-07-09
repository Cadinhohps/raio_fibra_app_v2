class RaioIaService {
  String responder(String mensagem) {
    final texto = mensagem.toLowerCase();

    if (texto.contains('sem internet') ||
        texto.contains('caiu') ||
        texto.contains('offline') ||
        texto.contains('não funciona') ||
        texto.contains('nao funciona')) {
      return 'Entendi. Vamos fazer uma triagem rápida antes de abrir chamado.\n\n'
          '1. Verifique se a luz LOS do roteador está vermelha ou piscando.\n'
          '2. Reinicie o roteador da tomada por 30 segundos.\n'
          '3. Confira se os cabos estão bem encaixados.\n\n'
          'Se após esses testes continuar sem internet, posso orientar a abertura de chamado técnico.';
    }

    if (texto.contains('lenta') ||
        texto.contains('devagar') ||
        texto.contains('travando') ||
        texto.contains('lentidão') ||
        texto.contains('lentidao')) {
      return 'Certo. Para internet lenta, vamos verificar alguns pontos:\n\n'
          '1. Teste perto do roteador.\n'
          '2. Feche vídeos, downloads e jogos.\n'
          '3. Reinicie o roteador.\n'
          '4. Faça um teste de velocidade.\n\n'
          'Se o resultado continuar muito abaixo do plano, podemos abrir chamado com prioridade.';
    }

    if (texto.contains('boleto') ||
        texto.contains('fatura') ||
        texto.contains('segunda via') ||
        texto.contains('pix') ||
        texto.contains('pagar')) {
      return 'Posso ajudar com isso. Vá na aba Faturas para consultar a fatura atual, PIX copia e cola, QR Code e botão de pagamento.\n\n'
          'Na versão final, essa consulta será integrada ao SGP e ao Mercado Pago.';
    }

    if (texto.contains('chamado') ||
        texto.contains('técnico') ||
        texto.contains('tecnico') ||
        texto.contains('suporte')) {
      return 'Antes de abrir o chamado, preciso entender melhor:\n\n'
          'Qual é o problema?\n'
          'Quando começou?\n'
          'Já reiniciou o roteador?\n'
          'A luz LOS está vermelha?\n\n'
          'Com essas informações, o chamado chega mais completo para o suporte.';
    }

    if (texto.contains('plano') ||
        texto.contains('upgrade') ||
        texto.contains('velocidade') ||
        texto.contains('promoção') ||
        texto.contains('promocao')) {
      return 'Temos opções de upgrade e promoções disponíveis. Na versão final, vou consultar os planos ativos do provedor e sugerir o melhor plano para seu perfil de uso.';
    }

    if (texto.contains('wifi') ||
        texto.contains('senha') ||
        texto.contains('roteador')) {
      return 'Para problemas de Wi-Fi, verifique:\n\n'
          '1. Se está conectado na rede correta.\n'
          '2. Se a senha foi alterada recentemente.\n'
          '3. Se o roteador está em local aberto.\n'
          '4. Se há muitos dispositivos conectados.\n\n'
          'Na versão final, a função “Meu Wi-Fi” poderá mostrar nome da rede, senha e dispositivos.';
    }

    return 'Entendi. Vou tentar te ajudar antes de abrir chamado.\n\n'
        'Você pode me dizer se o assunto é:\n'
        '• Sem internet\n'
        '• Internet lenta\n'
        '• Fatura ou PIX\n'
        '• Suporte técnico\n'
        '• Mudança de plano\n'
        '• Wi-Fi';
  }
}
