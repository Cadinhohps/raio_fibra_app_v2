import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';
import 'abrir_chamado_page.dart';
import 'historico_chamados_page.dart';
import 'raio_ia_page.dart';

class SuportePage extends StatelessWidget {
  const SuportePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categorias = [
      {'nome': 'Sem internet', 'icon': Icons.wifi_off},
      {'nome': 'Internet lenta', 'icon': Icons.speed},
      {'nome': 'Oscilacao', 'icon': Icons.show_chart},
      {'nome': 'Financeiro', 'icon': Icons.attach_money},
      {'nome': 'Mudanca', 'icon': Icons.home_work},
      {'nome': 'Outros', 'icon': Icons.more_horiz},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Suporte',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'A Raio IA tenta resolver antes de abrir chamado.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.orange,
                      child: Icon(Icons.smart_toy, color: Colors.white),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Raio IA Online',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Diagnostico rapido e abertura se necessario.',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RaioIaPage()),
                        );
                      },
                      child: const Text('Iniciar'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const PremiumCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Color(0xFFEAF0FF),
                      child: Icon(Icons.timer, color: AppColors.secondaryBlue),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SLA de atendimento',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Chamados normais ate 4h uteis. Prioridade alta ate 2h uteis.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AbrirChamadoPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add_task),
                      label: const Text('Abrir chamado'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HistoricoChamadosPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.history),
                      label: const Text('Historico'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                'Categorias de suporte',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.7,
                children: categorias.map((item) {
                  return InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AbrirChamadoPage(),
                        ),
                      );
                    },
                    child: PremiumCard(
                      child: Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            color: AppColors.secondaryBlue,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item['nome'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 22),
              const Text(
                'Chamados recentes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              PremiumCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.confirmation_number,
                    color: AppColors.secondaryBlue,
                  ),
                  title: const Text('Protocolo #RF1028'),
                  subtitle: const Text('Internet lenta - Em andamento'),
                  trailing: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HistoricoChamadosPage(),
                        ),
                      );
                    },
                    child: const Text('Ver'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
