import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class SuportePage extends StatelessWidget {
  const SuportePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categorias = [
      {'nome': 'Sem internet', 'icon': Icons.wifi_off},
      {'nome': 'Internet lenta', 'icon': Icons.speed},
      {'nome': 'Oscilação', 'icon': Icons.show_chart},
      {'nome': 'Financeiro', 'icon': Icons.attach_money},
      {'nome': 'Mudança', 'icon': Icons.home_work},
      {'nome': 'Outros', 'icon': Icons.more_horiz},
    ];

    return SafeArea(
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
                          'Diagnóstico rápido e abertura de chamado se necessário.',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Iniciar'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Abrir chamado',
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
                return PremiumCard(
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
            const PremiumCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  Icons.confirmation_number,
                  color: AppColors.secondaryBlue,
                ),
                title: Text('Protocolo #1028'),
                subtitle: Text('Internet lenta • Em andamento'),
                trailing: Chip(label: Text('SLA 4h')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
