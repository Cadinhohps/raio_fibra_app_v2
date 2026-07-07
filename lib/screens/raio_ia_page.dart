import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class RaioIaPage extends StatefulWidget {
  const RaioIaPage({super.key});

  @override
  State<RaioIaPage> createState() => _RaioIaPageState();
}

class _RaioIaPageState extends State<RaioIaPage> {
  final TextEditingController messageController = TextEditingController();

  final List<Map<String, dynamic>> messages = [
    {
      'fromUser': false,
      'text':
          'Olá! Eu sou a Raio IA. Antes de abrir um chamado, vou tentar resolver seu problema por aqui. Como posso ajudar?',
    },
  ];

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({'fromUser': true, 'text': text.trim()});

      messages.add({'fromUser': false, 'text': getMockResponse(text.trim())});
    });

    messageController.clear();
  }

  String getMockResponse(String text) {
    final lowerText = text.toLowerCase();

    if (lowerText.contains('sem internet') ||
        lowerText.contains('caiu') ||
        lowerText.contains('offline')) {
      return 'Entendi. Vamos verificar sua conexão. Primeiro, veja se a luz LOS do roteador está apagada ou vermelha. Se estiver vermelha, pode indicar rompimento ou ausência de sinal. Posso abrir um chamado técnico se o problema continuar.';
    }

    if (lowerText.contains('lenta') ||
        lowerText.contains('devagar') ||
        lowerText.contains('travando')) {
      return 'Certo. Para lentidão, feche aplicativos pesados, reinicie o roteador e faça um teste de velocidade perto do equipamento. Se o resultado continuar baixo, posso registrar um chamado com prioridade.';
    }

    if (lowerText.contains('boleto') ||
        lowerText.contains('fatura') ||
        lowerText.contains('segunda via') ||
        lowerText.contains('pix')) {
      return 'Posso te ajudar com a fatura. Acesse a aba Faturas para visualizar segunda via, PIX copia e cola e pagamento online.';
    }

    if (lowerText.contains('chamado') ||
        lowerText.contains('técnico') ||
        lowerText.contains('tecnico')) {
      return 'Antes de abrir o chamado, vou registrar algumas informações: tipo do problema, horário em que começou e se já reiniciou o roteador. Isso ajuda o suporte a resolver mais rápido.';
    }

    return 'Entendi. Vou analisar sua solicitação. Você pode me informar se o problema é técnico, financeiro, alteração de plano ou atendimento comercial?';
  }

  void sendQuickOption(String text) {
    sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          _buildQuickOptions(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return ChatBubble(
                  text: message['text'],
                  fromUser: message['fromUser'],
                );
              },
            ),
          ),
          _buildInput(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryBlue.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: const [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.orange,
            child: Icon(Icons.smart_toy, color: Colors.white, size: 30),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Raio IA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Online agora • Atendimento inteligente',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          Icon(Icons.circle, color: Colors.greenAccent, size: 14),
        ],
      ),
    );
  }

  Widget _buildQuickOptions() {
    final options = [
      'Sem internet',
      'Internet lenta',
      'Segunda via',
      'Abrir chamado',
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final option = options[index];

          return ActionChip(
            backgroundColor: Colors.white,
            label: Text(option),
            avatar: const Icon(
              Icons.flash_on,
              color: AppColors.orange,
              size: 18,
            ),
            onPressed: () => sendQuickOption(option),
          );
        },
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE8EEF8))),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Digite sua mensagem...',
                filled: true,
                fillColor: AppColors.lightGray,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: sendMessage,
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: AppColors.orange,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () => sendMessage(messageController.text),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool fromUser;

  const ChatBubble({super.key, required this.text, required this.fromUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: fromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 310),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: fromUser ? AppColors.secondaryBlue : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(fromUser ? 18 : 4),
            bottomRight: Radius.circular(fromUser ? 4 : 18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: fromUser ? Colors.white : Colors.black87,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}
