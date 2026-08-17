import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'abrir_chamado_page.dart';
import 'historico_chamados_page.dart';
import 'raio_ia_page.dart';

class SuportePage extends StatelessWidget {
  const SuportePage({super.key});

  void abrirRaioIa(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RaioIaPage()),
    );
  }

  void abrirChamado(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const AbrirChamadoPage(categoriaInicial: 'Suporte técnico'),
      ),
    );
  }

  void abrirHistorico(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HistoricoChamadosPage()),
    );
  }

  Future<void> abrirWhatsApp(BuildContext context) async {
    const numeroWhatsapp = '5581989634191';

    const mensagem = '''
Olá, Raio Fibra Telecom!

Preciso de atendimento pelo suporte.
Cliente: Ricardo
Cliente ID: CLI001
''';

    final uri = Uri.parse(
      'https://wa.me/$numeroWhatsapp?text=${Uri.encodeComponent(mensagem)}',
    );

    final abriu = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!abriu && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF6A00),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.18),
                    ),
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Suporte',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF071B52),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 31,
                      backgroundColor: Color(0xFFFF6A00),
                      child: Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Central de suporte',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Escolha como deseja ser atendido.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              _SuporteBotao(
                icon: Icons.psychology_alt,
                titulo: 'Atendimento com IA',
                subtitulo: 'Fale com a Raio IA para resolver dúvidas rápidas.',
                textoBotao: 'Falar com IA',
                onTap: () => abrirRaioIa(context),
              ),

              const SizedBox(height: 14),

              _SuporteBotao(
                icon: Icons.chat,
                titulo: 'WhatsApp',
                subtitulo: 'Abrir atendimento direto pelo WhatsApp.',
                textoBotao: 'Abrir WhatsApp',
                onTap: () => abrirWhatsApp(context),
              ),

              const SizedBox(height: 14),

              _SuporteBotao(
                icon: Icons.add_task,
                titulo: 'Abrir chamado',
                subtitulo: 'Abra um protocolo para acompanhamento técnico.',
                textoBotao: 'Abrir chamado',
                onTap: () => abrirChamado(context),
              ),

              const SizedBox(height: 14),

              _SuporteBotao(
                icon: Icons.history,
                titulo: 'Meus chamados',
                subtitulo: 'Acompanhe chamados abertos e resolvidos.',
                textoBotao: 'Ver chamados',
                onTap: () => abrirHistorico(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuporteBotao extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String subtitulo;
  final String textoBotao;
  final VoidCallback onTap;

  const _SuporteBotao({
    required this.icon,
    required this.titulo,
    required this.subtitulo,
    required this.textoBotao,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFFFFF2E8),
                child: Icon(icon, color: const Color(0xFFFF6A00)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        color: Color(0xFF071B52),
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitulo,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF083BBD),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: onTap,
              child: Text(
                textoBotao,
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
