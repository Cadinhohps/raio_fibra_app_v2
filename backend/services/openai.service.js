function buildReply(message = '') {
  const text = message.toLowerCase();

  if (
    text.includes('sem internet') ||
    text.includes('caiu') ||
    text.includes('offline') ||
    text.includes('sem conexao')
  ) {
    return 'Entendi que voce esta sem internet. Verifique se a luz LOS do roteador esta vermelha, reinicie o equipamento por 30 segundos e confira os cabos. Se continuar sem conexao, posso orientar a abertura de chamado tecnico.';
  }

  if (
    text.includes('lenta') ||
    text.includes('lentidao') ||
    text.includes('devagar') ||
    text.includes('travando')
  ) {
    return 'Para internet lenta, teste perto do roteador, feche downloads e videos, reinicie o equipamento e faca um teste de velocidade. Se o resultado ficar muito abaixo do plano, abrimos um chamado com prioridade.';
  }

  if (
    text.includes('segunda via') ||
    text.includes('fatura') ||
    text.includes('pix') ||
    text.includes('boleto')
  ) {
    return 'Posso ajudar com sua fatura. Voce pode consultar a segunda via, gerar PIX copia e cola e abrir o checkout simulado do Mercado Pago pela area de Faturas ou Pagamento.';
  }

  if (
    text.includes('abrir chamado') ||
    text.includes('chamado') ||
    text.includes('suporte tecnico') ||
    text.includes('suporte')
  ) {
    return 'Antes de abrir o chamado, me diga o problema, quando comecou, se ja reiniciou o roteador e se a luz LOS esta vermelha. Com isso o suporte recebe um atendimento mais completo.';
  }

  if (
    text.includes('wifi') ||
    text.includes('wi-fi') ||
    text.includes('senha') ||
    text.includes('roteador')
  ) {
    return 'Para Wi-Fi, confira se esta na rede correta, se a senha mudou, se o roteador esta em local aberto e quantos dispositivos estao conectados. A area Meu Wi-Fi ja esta preparada para integrar esses dados.';
  }

  if (
    text.includes('plano') ||
    text.includes('upgrade') ||
    text.includes('promocao')
  ) {
    return 'Temos opcoes de upgrade e promocoes. Para demonstracao, posso sugerir sair do plano 600 Mega para um plano superior conforme perfil de uso, com beneficios comerciais e fidelizacao.';
  }

  return 'Sou a Raio IA e posso ajudar com sem internet, internet lenta, segunda via, PIX, boleto, chamado, suporte tecnico, Wi-Fi, planos, upgrade e promocoes. Me diga o que voce precisa.';
}

async function sendChatMessage({ message, history }) {
  return {
    reply: buildReply(message),
    historyLength: Array.isArray(history) ? history.length : 0,
  };
}

module.exports = {
  sendChatMessage,
};
