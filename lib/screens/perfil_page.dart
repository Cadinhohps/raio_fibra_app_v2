import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';
import 'configuracoes_page.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final opcoes = [
      {'titulo': 'Alterar senha', 'icon': Icons.lock},
      {'titulo': 'Atualizar telefone', 'icon': Icons.phone},
      {'titulo': 'Atualizar endereco', 'icon': Icons.location_on},
      {'titulo': 'Preferencias', 'icon': Icons.settings},
      {'titulo': 'Sair da conta', 'icon': Icons.logout},
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
                'Perfil',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const PremiumCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: AppColors.secondaryBlue,
                      child: Icon(Icons.person, color: Colors.white, size: 34),
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ricardo',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Cliente Raio Fibra - Plano 600 Mega',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.edit, color: AppColors.secondaryBlue),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              ...opcoes.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PremiumCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(
                        item['icon'] as IconData,
                        color: AppColors.secondaryBlue,
                      ),
                      title: Text(item['titulo'] as String),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: item['titulo'] == 'Preferencias'
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ConfiguracoesPage(),
                                ),
                              );
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Funcionalidade preparada para integracao.',
                                  ),
                                ),
                              );
                            },
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
