import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/chamado_model.dart';
import '../services/sgp_service.dart';

class AbrirChamadoPage extends StatefulWidget {
  final String? categoriaInicial;

  const AbrirChamadoPage({super.key, this.categoriaInicial});

  @override
  State<AbrirChamadoPage> createState() => _AbrirChamadoPageState();
}

class _AbrirChamadoPageState extends State<AbrirChamadoPage> {
  final TextEditingController descricaoController = TextEditingController();
  final SgpService sgpService = SgpService();

  late String categoriaSelecionada;
  String prioridadeSelecionada = 'Normal';
  ChamadoModel? chamadoCriado;
  bool enviando = false;

  final List<String> prioridades = ['Baixa', 'Normal', 'Alta'];

  @override
  void initState() {
    super.initState();
    categoriaSelecionada = widget.categoriaInicial ?? 'Sem internet';
  }

  String getSlaText() {
    if (prioridadeSelecionada == 'Alta') return 'até 2h úteis';
    if (prioridadeSelecionada == 'Normal') return 'até 4h úteis';
    return 'até 8h úteis';
  }

  IconData get categoriaIcon {
    switch (categoriaSelecionada) {
      case 'Sem internet':
        return Icons.wifi_off;
      case 'Internet lenta':
        return Icons.speed;
      case 'Wi-Fi':
        return Icons.router;
      case 'Segunda via':
        return Icons.receipt_long;
      case 'Mudança de plano':
        return Icons.trending_up;
      case 'Suporte técnico':
        return Icons.engineering;
      default:
        return Icons.support_agent;
    }
  }

  List<String> get dicasCategoria {
    switch (categoriaSelecionada) {
      case 'Sem internet':
        return [
          'Verifique se o roteador está ligado na tomada.',
          'Confira se o cabo de fibra está bem conectado.',
          'Reinicie o roteador e aguarde 2 minutos.',
          'Se a luz vermelha continuar, envie o chamado.',
        ];
      case 'Internet lenta':
        return [
          'Faça o teste próximo ao roteador.',
          'Desconecte aparelhos que não está usando.',
          'Evite testar com downloads ou vídeos abertos.',
          'Informe no chamado se a lentidão acontece no cabo ou Wi-Fi.',
        ];
      case 'Wi-Fi':
        return [
          'Verifique se o nome da rede aparece no celular.',
          'Confirme se a senha está correta.',
          'Evite deixar o roteador atrás de paredes ou móveis.',
          'Reinicie o equipamento antes de enviar o chamado.',
        ];
      case 'Segunda via':
        return [
          'Confira se existe fatura em aberto na área de faturas.',
          'Use o Pix copia e cola, se disponível.',
          'Informe no chamado o mês da cobrança desejada.',
        ];
      case 'Mudança de plano':
        return [
          'Informe qual plano você deseja contratar.',
          'A mudança pode depender da disponibilidade técnica.',
          'Nossa equipe confirmará prazo e valores antes da ativação.',
        ];
      case 'Suporte técnico':
        return [
          'Descreva o problema com detalhes.',
          'Informe desde quando o problema acontece.',
          'Um atendente ou técnico poderá entrar em contato.',
        ];
      default:
        return [
          'Descreva sua solicitação com o máximo de detalhes.',
          'Informe horário, local e qualquer mensagem de erro.',
          'Nossa equipe vai analisar e retornar pelo atendimento.',
        ];
    }
  }

  Future<void> abrirChamado() async {
    if (enviando) return;

    final descricao = descricaoController.text.trim().isEmpty
        ? 'Cliente não informou descrição.'
        : descricaoController.text.trim();

    setState(() {
      enviando = true;
    });

    final resultado = await sgpService.abrirChamado(
      clienteId: 'CLI001',
      categoria: categoriaSelecionada,
      descricao: descricao,
      prioridade: prioridadeSelecionada,
    );

    if (!mounted) return;

    final novoChamado = ChamadoModel(
      protocolo: resultado['protocolo'] ?? '#RF1030',
      categoria: resultado['categoria'] ?? categoriaSelecionada,
      descricao: resultado['descricao'] ?? descricao,
      prioridade: resultado['prioridade'] ?? prioridadeSelecionada,
      status: resultado['status'] ?? 'Aberto',
      sla: resultado['sla'] ?? getSlaText(),
      criadoEm: DateTime.now(),
    );

    setState(() {
      chamadoCriado = novoChamado;
      enviando = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chamado ${novoChamado.protocolo} aberto com sucesso!'),
        backgroundColor: _TicketColors.blueDark,
      ),
    );
  }

  Future<void> enviarWhatsapp(ChamadoModel chamado) async {
    const numeroWhatsapp = '5581989634191';

    final mensagem =
        '''
Raio Fibra Telecom - Novo chamado

Protocolo: ${chamado.protocolo}
Cliente: Ricardo
Cliente ID: CLI001
Categoria: ${chamado.categoria}
Prioridade: ${chamado.prioridade}
Status: ${chamado.status}
SLA: ${chamado.sla}

Descrição:
${chamado.descricao}
''';

    final uri = Uri.parse(
      'https://wa.me/$numeroWhatsapp?text=${Uri.encodeComponent(mensagem)}',
    );

    final abriu = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!abriu && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o WhatsApp.')),
      );
    }
  }

  @override
  void dispose() {
    descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chamado = chamadoCriado;

    return Scaffold(
      backgroundColor: _TicketColors.orange,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 860),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TopBar(onBack: () => Navigator.pop(context)),
                  const SizedBox(height: 16),
                  _CategoryHero(
                    categoria: categoriaSelecionada,
                    icon: categoriaIcon,
                    sla: getSlaText(),
                  ),
                  const SizedBox(height: 18),
                  _TipsCard(dicas: dicasCategoria),
                  const SizedBox(height: 18),
                  _PriorityCard(
                    prioridades: prioridades,
                    prioridadeSelecionada: prioridadeSelecionada,
                    sla: getSlaText(),
                    onSelected: (prioridade) {
                      setState(() {
                        prioridadeSelecionada = prioridade;
                        chamadoCriado = null;
                      });
                    },
                  ),
                  const SizedBox(height: 18),
                  _DescriptionCard(controller: descricaoController),
                  const SizedBox(height: 18),
                  if (chamado != null)
                    _SuccessCard(
                      chamado: chamado,
                      onWhatsapp: () => enviarWhatsapp(chamado),
                    ),
                  if (chamado != null) const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _TicketColors.blueDark,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: enviando ? null : abrirChamado,
                      icon: enviando
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.send),
                      label: Text(
                        enviando ? 'Enviando...' : 'Enviar chamado',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TicketColors {
  static const orange = Color(0xFFFF6A00);
  static const blue = Color(0xFF083BBD);
  static const blueDark = Color(0xFF071B52);
  static const white = Color(0xFFFFFFFF);
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.18),
          ),
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Abrir chamado',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryHero extends StatelessWidget {
  final String categoria;
  final IconData icon;
  final String sla;

  const _CategoryHero({
    required this.categoria,
    required this.icon,
    required this.sla,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _TicketColors.blueDark,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: _TicketColors.orange,
            child: Icon(icon, color: Colors.white, size: 34),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoria,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Antes de enviar, veja as dicas rápidas abaixo.',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  'SLA estimado: $sla',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TipsCard extends StatelessWidget {
  final List<String> dicas;

  const _TipsCard({required this.dicas});

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lightbulb, color: _TicketColors.orange),
              SizedBox(width: 8),
              Text(
                'Dicas antes de enviar',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...dicas.map(
            (dica) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: _TicketColors.blue,
                    size: 19,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(dica, style: const TextStyle(height: 1.3)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriorityCard extends StatelessWidget {
  final List<String> prioridades;
  final String prioridadeSelecionada;
  final String sla;
  final ValueChanged<String> onSelected;

  const _PriorityCard({
    required this.prioridades,
    required this.prioridadeSelecionada,
    required this.sla,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prioridade',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: prioridades.map((prioridade) {
              final selected = prioridade == prioridadeSelecionada;

              return ChoiceChip(
                label: Text(prioridade),
                selected: selected,
                selectedColor: _TicketColors.orange,
                backgroundColor: const Color(0xFFFFF2E8),
                labelStyle: TextStyle(
                  color: selected ? Colors.white : _TicketColors.blueDark,
                  fontWeight: FontWeight.bold,
                ),
                onSelected: (_) => onSelected(prioridade),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Text(
            'SLA estimado: $sla',
            style: const TextStyle(
              color: _TicketColors.blue,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  final TextEditingController controller;

  const _DescriptionCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return _WhiteCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Descrição do problema',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText:
                  'Exemplo: estou sem internet desde ontem à noite. O roteador está com luz vermelha...',
              filled: true,
              fillColor: const Color(0xFFFFF2E8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessCard extends StatelessWidget {
  final ChamadoModel chamado;
  final VoidCallback onWhatsapp;

  const _SuccessCard({required this.chamado, required this.onWhatsapp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _TicketColors.blue,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: _TicketColors.blueDark.withOpacity(0.3),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.check, color: _TicketColors.orange),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Chamado ${chamado.protocolo} aberto com sucesso.\n'
                  'Categoria: ${chamado.categoria}\n'
                  'Prioridade: ${chamado.prioridade}\n'
                  'Status: ${chamado.status}\n'
                  'SLA: ${chamado.sla}',
                  style: const TextStyle(
                    color: Colors.white,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: _TicketColors.blueDark,
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: onWhatsapp,
              icon: const Icon(Icons.chat),
              label: const Text(
                'Enviar também pelo WhatsApp',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WhiteCard extends StatelessWidget {
  final Widget child;

  const _WhiteCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _TicketColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
