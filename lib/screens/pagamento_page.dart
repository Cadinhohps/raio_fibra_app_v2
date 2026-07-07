import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/premium_card.dart';

class PagamentoPage extends StatelessWidget {
  const PagamentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    const pixCode =
        '00020126580014br.gov.bcb.pix0136raiofibra-pagamento-demo520400005303986540599.905802BR5920RAIO FIBRA INTERNET6009PERNAMBUCO62070503***6304ABCD';

    return SafeArea(
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
                const Text(
                  'Pagamento',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 16),

            PremiumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Fatura atual',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'R\$ 99,90',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text('Vencimento: 10/07/2026'),
                  Text('Status: Em aberto'),
                ],
              ),
            ),

            const SizedBox(height: 18),

            PremiumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Pagar com PIX',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 14),

                  Center(
                    child: Container(
                      width: 190,
                      height: 190,
                      decoration: BoxDecoration(
                        color: AppColors.lightGray,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: const Color(0xFFE0E7F3)),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.qr_code_2,
                          size: 130,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      pixCode,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Código PIX copiado com sucesso!'),
                            backgroundColor: AppColors.secondaryBlue,
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text(
                        'Copiar PIX',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            PremiumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mercado Pago',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Na versão final, este botão abrirá o checkout real do Mercado Pago.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Checkout Mercado Pago será integrado futuramente.',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.payment),
                      label: const Text('Abrir checkout Mercado Pago'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
