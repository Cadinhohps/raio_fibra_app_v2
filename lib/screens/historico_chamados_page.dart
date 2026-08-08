import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class HistoricoChamadosPage extends StatelessWidget {
  const HistoricoChamadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chamados = [
      {
        'protocolo': '#RF1030',
        'categoria': 'Sem internet',
        'status': 'Aberto',
        'sla': 'ate 4h uteis',
      },
      {
        'protocolo': '#RF1028',
        'categoria': 'Internet lenta',
        'status': 'Em andamento',
        'sla': 'ate 4h uteis',
      },
      {
        'protocolo': '#RF1019',
        'categoria': 'Financeiro',
        'status': 'Resolvido',
        'sla': 'concluido',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Historico',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        Text(
                          'Chamados simulados do cliente.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ...chamados.map((chamado) {
                final aberto = chamado['status'] != 'Resolvido';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: PremiumCard(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: aberto
                            ? const Color(0xFFFFE8D6)
                            : Colors.green.shade50,
                        child: Icon(
                          aberto ? Icons.schedule : Icons.check,
                          color: aberto ? AppColors.orange : AppColors.success,
                        ),
                      ),
                      title: Text(
                        chamado['protocolo']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${chamado['categoria']} - ${chamado['sla']}',
                      ),
                      trailing: Text(
                        chamado['status']!,
                        style: TextStyle(
                          color: aberto ? AppColors.orange : AppColors.success,
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
