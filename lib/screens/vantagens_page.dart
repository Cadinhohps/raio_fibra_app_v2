import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class VantagensPage extends StatelessWidget {
  const VantagensPage({super.key});

  @override
  Widget build(BuildContext context) {
    final vantagens = [
      {
        'titulo': 'Promocoes',
        'desc': 'Ofertas exclusivas para clientes.',
        'icon': Icons.local_offer,
      },
      {
        'titulo': 'Parceiros',
        'desc': 'Descontos em empresas parceiras.',
        'icon': Icons.handshake,
      },
      {
        'titulo': 'Streaming',
        'desc': 'Combos e beneficios digitais.',
        'icon': Icons.play_circle,
      },
      {
        'titulo': 'Indique e Ganhe',
        'desc': 'Ganhe bonus indicando amigos.',
        'icon': Icons.group_add,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vantagens',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Beneficios comerciais para fidelizar clientes.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.primaryBlue,
                          AppColors.secondaryBlue,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cliente Diamante',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Voce tem 850 pontos acumulados.',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 14),
                        LinearProgressIndicator(
                          value: 0.85,
                          color: AppColors.orange,
                          backgroundColor: Colors.white24,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  ...vantagens.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: PremiumCard(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFEAF0FF),
                            child: Icon(
                              item['icon'] as IconData,
                              color: AppColors.secondaryBlue,
                            ),
                          ),
                          title: Text(
                            item['titulo'] as String,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(item['desc'] as String),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
