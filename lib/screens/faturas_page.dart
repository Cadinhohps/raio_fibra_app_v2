import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class FaturasPage extends StatelessWidget {
  const FaturasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final faturas = [
      {
        'mes': 'Julho/2026',
        'valor': 'R\$ 99,90',
        'status': 'Em aberto',
        'vencimento': '10/07/2026',
      },
      {
        'mes': 'Junho/2026',
        'valor': 'R\$ 99,90',
        'status': 'Pago',
        'vencimento': '10/06/2026',
      },
      {
        'mes': 'Maio/2026',
        'valor': 'R\$ 99,90',
        'status': 'Pago',
        'vencimento': '10/05/2026',
      },
    ];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Faturas',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Consulte, pague e baixe suas faturas.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            PremiumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Fatura atual',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'R\$ 99,90',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const Text('Vencimento: 10/07/2026'),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.payment),
                      label: const Text('Pagar agora'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.pix),
                    label: const Text('PIX copia e cola'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            const Text(
              'Histórico',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...faturas.map((fatura) {
              final pago = fatura['status'] == 'Pago';
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PremiumCard(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: pago
                            ? Colors.green.shade50
                            : Colors.orange.shade50,
                        child: Icon(
                          pago ? Icons.check : Icons.warning_amber,
                          color: pago ? Colors.green : AppColors.orange,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fatura['mes']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Vencimento: ${fatura['vencimento']}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            fatura['valor']!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            fatura['status']!,
                            style: TextStyle(
                              color: pago ? Colors.green : AppColors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
