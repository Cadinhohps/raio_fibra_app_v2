import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class BeneficiosPage extends StatelessWidget {
  const BeneficiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final beneficios = [
      '10% de desconto em upgrade de plano',
      'Instalacao gratuita para indicados',
      'Clube de parceiros locais',
      'Atendimento prioritario para cliente Diamante',
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _BenefitHeader(onBack: () => Navigator.pop(context)),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
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
                      '850 pontos acumulados para troca futura.',
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
              ...beneficios.map((beneficio) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PremiumCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.verified,
                        color: AppColors.secondaryBlue,
                      ),
                      title: Text(beneficio),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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

class _BenefitHeader extends StatelessWidget {
  final VoidCallback onBack;

  const _BenefitHeader({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Beneficios',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryBlue,
                ),
              ),
              Text(
                'Vantagens comerciais para fidelizacao.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
