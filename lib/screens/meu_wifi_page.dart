import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class MeuWifiPage extends StatelessWidget {
  const MeuWifiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dispositivos = [
      {'nome': 'Smart TV Sala', 'tipo': 'Streaming', 'status': 'Online'},
      {'nome': 'Notebook Ricardo', 'tipo': 'Trabalho', 'status': 'Online'},
      {'nome': 'Celular Familia', 'tipo': 'Mobile', 'status': 'Online'},
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PageTitle(
                title: 'Meu Wi-Fi',
                subtitle: 'Rede, senha e dispositivos conectados.',
                onBack: () => Navigator.pop(context),
              ),
              const SizedBox(height: 18),
              PremiumCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Color(0xFFEAF0FF),
                          child: Icon(
                            Icons.router,
                            color: AppColors.secondaryBlue,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'RaioFibra_600M',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Chip(label: Text('Online')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _InfoLine(label: 'Senha', value: 'raiofibra-demo'),
                    _InfoLine(label: 'Frequencia', value: '2.4 GHz e 5 GHz'),
                    _InfoLine(label: 'Sinal', value: 'Excelente'),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Senha copiada para demonstracao.'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.copy),
                        label: const Text('Copiar senha'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Dispositivos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...dispositivos.map((device) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PremiumCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.devices,
                        color: AppColors.secondaryBlue,
                      ),
                      title: Text(device['nome']!),
                      subtitle: Text(device['tipo']!),
                      trailing: Text(
                        device['status']!,
                        style: const TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.bold,
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

class _PageTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;

  const _PageTitle({
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

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
