import 'package:flutter/material.dart';

import '../models/chat_message_model.dart';
import '../services/openai_service.dart';
import '../theme/app_theme.dart';

class RaioIaPage extends StatefulWidget {
  const RaioIaPage({super.key});

  @override
  State<RaioIaPage> createState() => _RaioIaPageState();
}

class _RaioIaPageState extends State<RaioIaPage> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final OpenAiService openAiService = OpenAiService();

  final List<ChatMessageModel> messages = [
    ChatMessageModel(
      fromUser: false,
      text:
          'Ola! Eu sou a Raio IA. Antes de abrir chamado, vou tentar resolver seu problema por aqui. Como posso ajudar?',
      createdAt: DateTime.now(),
    ),
  ];

  bool isTyping = false;

  void sendMessage(String text) async {
    final message = text.trim();

    if (message.isEmpty) return;

    setState(() {
      messages.add(
        ChatMessageModel(
          text: message,
          fromUser: true,
          createdAt: DateTime.now(),
        ),
      );

      isTyping = true;
    });

    messageController.clear();
    scrollToBottom();

    final resposta = await openAiService.enviarMensagem(
      mensagem: message,
      historico: messages.map((item) => item.toJson()).toList(),
    );

    if (!mounted) return;

    setState(() {
      messages.add(
        ChatMessageModel(
          text: resposta,
          fromUser: false,
          createdAt: DateTime.now(),
        ),
      );

      isTyping = false;
    });

    scrollToBottom();
  }

  void sendQuickOption(String text) {
    sendMessage(text);
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (!scrollController.hasClients) return;

      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildQuickOptions(),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(18),
                itemCount: messages.length + (isTyping ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isTyping && index == messages.length) {
                    return const TypingBubble();
                  }

                  final message = messages[index];

                  return ChatBubble(
                    text: message.text,
                    fromUser: message.fromUser,
                  );
                },
              ),
            ),
            _buildInput(),
          ],
        ),
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
                  'Online agora - Atendimento inteligente',
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
      'Problema no Wi-Fi',
      'Upgrade de plano',
    ];

    return SizedBox(
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        itemCount: options.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
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
        constraints: const BoxConstraints(maxWidth: 330),
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

class TypingBubble extends StatelessWidget {
  const TypingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.secondaryBlue,
              ),
            ),
            SizedBox(width: 10),
            Text('Raio IA digitando...', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
