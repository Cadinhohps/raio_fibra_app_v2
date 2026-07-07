import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';
import '../models/fatura_model.dart';
import 'pagamento_page.dart';

class FaturasPage extends StatelessWidget {
  const FaturasPage({super.key});

  @override
  Widget build(BuildContext context) {
    const faturas = [
      FaturaModel(
        competencia: 'Julho/2026',
        valor: 'R\$ 99,90',
        vencimento: '10/07/2026',
        status: 'Em aberto',
        pixCopiaCola:
            '00020126580014br.gov.bcb.pix0136raiofibra-pagamento-demo520400005303986540599.905802BR5920RAIO FIBRA INTERNET6009PERNAMBUCO62070503***6304ABCD',
        pdfUrl: '',
      ),
      FaturaModel(
        competencia: 'Junho/2026',
        valor: 'R\$ 99,90',
        vencimento: '10/06/2026',
        status: 'Pago',
        pixCopiaCola: '',
        pdfUrl: '',
      ),
      FaturaModel(
        competencia: 'Maio/2026',
        valor: 'R\$ 99,90',
        vencimento: '10/05/2026',
        status: 'Pago',
        pixCopiaCola: '',
        pdfUrl: '',
      ),
    ];

    final faturaAtual = faturas.first;

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
                  Text(
                    faturaAtual.valor,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Vencimento: ${faturaAtual.vencimento}'),
                  Text('Status: ${faturaAtual.status}'),
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PagamentoPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.payment),
                      label: const Text(
                        'Pagar agora',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'PIX copia e cola será exibido na tela de pagamento.',
                            ),
                            backgroundColor: AppColors.secondaryBlue,
                          ),
                        );
                      },
                      icon: const Icon(Icons.pix),
                      label: const Text('PIX copia e cola'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'PDF da fatura será integrado futuramente.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text('Baixar PDF'),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'Promessa de pagamento',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            PremiumCard(
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFFFFE8D6),
                    child: Icon(Icons.schedule, color: AppColors.orange),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Precisa de mais tempo?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Informe promessa de pagamento em até 24h.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Promessa de pagamento registrada por 24h.',
                          ),
                          backgroundColor: AppColors.secondaryBlue,
                        ),
                      );
                    },
                    child: const Text('Prometer'),
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
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PremiumCard(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: fatura.estaPago
                            ? Colors.green.shade50
                            : Colors.orange.shade50,
                        child: Icon(
                          fatura.estaPago ? Icons.check : Icons.warning_amber,
                          color: fatura.estaPago
                              ? Colors.green
                              : AppColors.orange,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fatura.competencia,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Vencimento: ${fatura.vencimento}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            fatura.valor,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            fatura.status,
                            style: TextStyle(
                              color: fatura.estaPago
                                  ? Colors.green
                                  : AppColors.orange,
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
