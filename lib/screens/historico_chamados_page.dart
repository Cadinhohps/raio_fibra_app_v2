import 'package:flutter/material.dart';

class HistoricoChamadosPage extends StatelessWidget {
  const HistoricoChamadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chamados = [
      const _ChamadoItem(
        protocolo: '#RF1030',
        categoria: 'Sem internet',
        status: 'Aberto',
        prioridade: 'Normal',
        sla: 'até 4h úteis',
        data: 'Hoje, 09:20',
        descricao: 'Cliente informou ausência de conexão.',
      ),
      const _ChamadoItem(
        protocolo: '#RF1028',
        categoria: 'Internet lenta',
        status: 'Em andamento',
        prioridade: 'Alta',
        sla: 'até 2h úteis',
        data: 'Ontem, 16:45',
        descricao: 'Lentidão no Wi-Fi e instabilidade no período da noite.',
      ),
      const _ChamadoItem(
        protocolo: '#RF1019',
        categoria: 'Segunda via',
        status: 'Resolvido',
        prioridade: 'Baixa',
        sla: 'concluído',
        data: '12/08/2026, 10:10',
        descricao: 'Solicitação de segunda via enviada ao cliente.',
      ),
    ];

    final abertos = chamados.where((c) => c.status == 'Aberto').length;
    final andamento = chamados.where((c) => c.status == 'Em andamento').length;
    final resolvidos = chamados.where((c) => c.status == 'Resolvido').length;

    return Scaffold(
      backgroundColor: _HistoryColors.orange,
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
                  _HeroCard(
                    abertos: abertos,
                    andamento: andamento,
                    resolvidos: resolvidos,
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Chamados recentes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Acompanhe protocolos abertos, em andamento e resolvidos.',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 14),
                  ...chamados.map(
                    (chamado) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _ChamadoCard(chamado: chamado),
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

class _HistoryColors {
  static const orange = Color(0xFFFF6A00);
  static const blue = Color(0xFF083BBD);
  static const blueDark = Color(0xFF071B52);
  static const white = Color(0xFFFFFFFF);
  static const green = Color(0xFF00A86B);
  static const yellow = Color(0xFFFFB300);
}

class _ChamadoItem {
  final String protocolo;
  final String categoria;
  final String status;
  final String prioridade;
  final String sla;
  final String data;
  final String descricao;

  const _ChamadoItem({
    required this.protocolo,
    required this.categoria,
    required this.status,
    required this.prioridade,
    required this.sla,
    required this.data,
    required this.descricao,
  });
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
            'Meus chamados',
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

class _HeroCard extends StatelessWidget {
  final int abertos;
  final int andamento;
  final int resolvidos;

  const _HeroCard({
    required this.abertos,
    required this.andamento,
    required this.resolvidos,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _HistoryColors.blueDark,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: _HistoryColors.orange,
                child: Icon(
                  Icons.confirmation_number,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Histórico de atendimento',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Protocolos da Raio Fibra Telecom',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _SummaryBox(
                  value: abertos.toString(),
                  label: 'Abertos',
                  icon: Icons.radio_button_checked,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryBox(
                  value: andamento.toString(),
                  label: 'Andamento',
                  icon: Icons.sync,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _SummaryBox(
                  value: resolvidos.toString(),
                  label: 'Resolvidos',
                  icon: Icons.check_circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _SummaryBox({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ChamadoCard extends StatelessWidget {
  final _ChamadoItem chamado;

  const _ChamadoCard({required this.chamado});

  Color get statusColor {
    if (chamado.status == 'Resolvido') return _HistoryColors.green;
    if (chamado.status == 'Em andamento') return _HistoryColors.yellow;
    return _HistoryColors.orange;
  }

  IconData get statusIcon {
    if (chamado.status == 'Resolvido') return Icons.check_circle;
    if (chamado.status == 'Em andamento') return Icons.sync;
    return Icons.schedule;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _HistoryColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 27,
                backgroundColor: statusColor.withOpacity(0.14),
                child: Icon(statusIcon, color: statusColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chamado.protocolo,
                      style: const TextStyle(
                        color: _HistoryColors.blueDark,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      chamado.categoria,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusPill(label: chamado.status, color: statusColor),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            chamado.descricao,
            style: const TextStyle(color: Colors.black87, height: 1.35),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _InfoPill(
                icon: Icons.priority_high,
                label: 'Prioridade: ${chamado.prioridade}',
              ),
              _InfoPill(icon: Icons.timer, label: 'SLA: ${chamado.sla}'),
              _InfoPill(icon: Icons.calendar_today, label: chamado.data),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusPill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.13),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF2E8),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _HistoryColors.orange, size: 15),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: _HistoryColors.blueDark,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
