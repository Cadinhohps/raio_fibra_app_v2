import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class ConsumoPage extends StatelessWidget {
  const ConsumoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usos = [
      {'label': 'Streaming', 'value': '48%', 'icon': Icons.live_tv},
      {'label': 'Trabalho', 'value': '28%', 'icon': Icons.laptop_mac},
      {'label': 'Jogos', 'value': '16%', 'icon': Icons.sports_esports},
      {'label': 'Outros', 'value': '8%', 'icon': Icons.more_horiz},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SimpleHeader(
                title: 'Consumo',
                subtitle: 'Leitura simulada do perfil de uso.',
                onBack: () => Navigator.pop(context),
              ),
              const SizedBox(height: 18),
              const PremiumCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consumo do mes',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '842 GB',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                    SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.72,
                      color: AppColors.orange,
                      backgroundColor: Color(0xFFEAF0FF),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Uso por categoria',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...usos.map((uso) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PremiumCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        uso['icon'] as IconData,
                        color: AppColors.secondaryBlue,
                      ),
                      title: Text(uso['label'] as String),
                      trailing: Text(
                        uso['value'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const _SimpleHeader({
    required this.title,
    required this.subtitle,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}
